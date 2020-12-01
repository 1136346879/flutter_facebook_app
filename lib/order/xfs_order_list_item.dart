
import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/xfs_goods_model.dart';
import 'package:flutter_facebook/models/xfs_order_model.dart';
import 'package:flutter_facebook/order/xfs_order_utils.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:flutter_facebook/util/xfs_img_loader.dart';

/// Created by liuwei
/// on 2020-09-18
/// page xfs_order_list_item
/// 订单列表item

class XFSOrderListHeader extends StatelessWidget {

  final XFSOrderListModel model;
  final XFSItemClickDelegate clickDelegate;
  final int section;

  const XFSOrderListHeader({Key key, this.model, this.clickDelegate, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XFSContainer(
      onTap: (){
        if (clickDelegate != null){
          clickDelegate?.didSelectCell(section: section, clickType: 1, data: model);
        }
      },
      child: Column(
        children: [
          Container(
            height: model.isChildOrder ? 0 : 10,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: model.isChildOrder ? Colors.black12 : Config.colorEFEFEF,
                    blurRadius: model.isChildOrder ? 2.0 : 0, //阴影模糊程度
                    spreadRadius: model.isChildOrder ? 1.0 : 0, //阴影扩散程度
                  ),
                ]
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              child: Row(
                children: [
                  XFSTextView('订单号：${model.order_id}', fontSize: 14,),
                  InkWell(
                    highlightColor: Colors.grey,
                    onTap: (){
                      XFSUtils.copyData(model.order_id);
                      XFSCommonUtils.showToast(msg: '已复制到剪切板');
                    },
                    child: XFSText('复制',
                      height: 22,
                      fontSize: 12,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.grey, width: 1),
                      padding: EdgeInsets.symmetric( horizontal: 5),
                      margin: EdgeInsets.only(left: 8),
                    ),
                  ),
                  Expanded(
                    child: _orderStatusView(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 订单状态显示。
  Widget _orderStatusView(){
    /// 如果是拆分订单就显示拆分，查看详情
    if (model.order_split_status == 20){
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            XFSText(
              '已拆分',
              padding: EdgeInsets.only(right: 10),
              fontSize: 12,
              textColor: Config.colorFFA200,
              fontWeight: FontWeight.w600,
            ),
            XFSContainer(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Config.colorFFA200, width: 1),
              padding: EdgeInsets.all(5),
              child: XFSTextView(
                '查看详情',
                textColor: Config.colorFFA200,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }else{
      var orderStatus = XFSOrderUtils().pageShowOrderStatusString(model.order_status, model.cancle_apply_show, model.paid_type);
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            invoiceImage(),
            XFSText(
              model.order_split_status == 10 ? "$orderStatus（拆分中）" : orderStatus,
              fontSize: 12,
              textColor: Config.colorFFA200,
              alignment: Alignment.centerRight,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
    }
  }

  /// 开票图标显示，
  Widget invoiceImage(){
    if (model.order_status == 100){
      return SizedBox(width: 0,);
    }
    String imageAsset = R.invoiceNo;

    if(model?.orderInvoice?.invoice_sorce == 10){
      var curStatus = model.orderInvoice.invoice_status;
      if(curStatus==10 || curStatus==60 ){
        imageAsset = R.invoiceNo;
      }else if(curStatus ==50){
        imageAsset = R.invoiceEd;
      }else{
        imageAsset = R.invoiceIng;
      }
    }
    return Container(
      margin: EdgeInsets.only(right: 2),
      child: Image.asset(imageAsset, width: 40, height: 40,),
    );
  }
}

class XFSOrderListItem extends StatelessWidget {

  final XFSItemClickDelegate clickDelegate;
  final XFSGoodsModel model;
  final XFSOrderListModel listModel;
  final Color bgColor;
  final int section;
  final int row;
  /// 是否显示右侧价格和数量
  final bool showPriceAnCount;

  const XFSOrderListItem({
    Key key,
    this.clickDelegate,
    this.model,
    this.section,
    this.row,
    this.listModel,
    this.bgColor=Config.colorFAFAFA,
    this.showPriceAnCount=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: showPriceAnCount ? 15 : 20, vertical: 11),
        color: bgColor,
        alignment: Alignment.center,
        child: Row(
          children: [
            _leftImage(),
            Expanded(
              child: XFSContainer(
                margin: EdgeInsets.only(left: 11),
                child: Column(
                  children: [
                    _rightTopView(),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: _rightBottomView(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        if (showPriceAnCount){
          clickDelegate?.didSelectCell(section: section, row: row, clickType: 1, data: listModel,data1:"商品详情页");
        }
      },
    );
  }

  /// 商品图片
  Widget _leftImage(){

    double imageSize = showPriceAnCount ? 42 : 64;

    /// 签约用户直接显示图片。为签约用户需要判断是否危险品。
    if (showPriceAnCount && !XFSCommonUtils.contract()){
      return Stack(
        children: [
          XFSContainer(
            width: 42,
            height: 42,
            child: XFSNetImageLoader.loadNetImage(url: model.product_pic, width: 42, height: 42),
          ),
          XFSContainer(
            width: 18,
            height: 18,
            margin: EdgeInsets.only(left: 40, top: 24),
            child: Offstage(
              offstage: !model.isDangerous(),
              child: Image.asset(R.danger,),
            ),
          )
        ],
      );
    }
    return XFSContainer(
      width: imageSize,
      height: imageSize,
      child: XFSNetImageLoader.loadNetImage(url: model.product_pic, width: 42, height: 42),
      border: showPriceAnCount ? null : Border.all(color: Config.colorE7E7E7, width: 1),
    );
  }

  /// 商品名称和价格
  Widget _rightTopView(){

    var sale_price = model.sale_price;

    var sale_pricenr = 0.0;

    if (model.activity_type == 10) {
      sale_pricenr = XFSNumUtil.divide(model.promotion_value, model.buyyer_count);
    };
    //运费分摊
    if (listModel?.separate_shipping_fee == 20) {
      sale_price = XFSNumUtil.add(XFSNumUtil.divide(model.fare, model.buyyer_count), model.sale_price);
    }
    sale_price = XFSNumUtil.subtract(sale_price, sale_pricenr);
    var salePriceString = XFSNumUtil.getNumStringByValueDouble(sale_price, 2);

    return Row(
      children: [
        Expanded(
          child: Container(
            child: XFSTextView(model.product_name??'', fontSize: 12, fontWeight: showPriceAnCount ? FontWeight.w600 : FontWeight.w400,),
            padding: EdgeInsets.only(right: 65),
          ),
        ),
        showPriceAnCount ? XFSTextView('¥$salePriceString', fontSize: 12, fontWeight: FontWeight.w600,) : SizedBox(width: 0,),
      ],
    );
  }

  /// 商品描述和购买单位数量
  Widget _rightBottomView(){

    var buyyerCount;
    if (showPriceAnCount){
      buyyerCount = XFSNumUtil.doubleTrans(model.buyyer_count);
    }

    return Row(
      children: [
        Expanded(
          child: XFSTextView(model.sku_info??'', fontSize: 10, fontWeight: FontWeight.w400, textColor: showPriceAnCount ? Config.color666666 : Config.color333333),
        ),
        showPriceAnCount ? XFSTextView('x${buyyerCount}${model.unit_name}', fontSize: 10, fontWeight: FontWeight.w400, textColor: Config.color666666,) : SizedBox(width: 0,),
      ],
    );
  }

}

class XFSOrderListFooter extends StatelessWidget {

  final XFSOrderListModel model;
  final XFSItemClickDelegate clickDelegate;
  final int section;

  const XFSOrderListFooter({Key key, this.model, this.clickDelegate, this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return XFSContainer(
      child: Column(
        children: [
          _moreView(),
          _totalAmountView(),
          model.order_split_status == 10 ? SizedBox(height: 0,) : Divider(),
          model.order_split_status == 10 ? SizedBox(height: 0,) : _bottomView(),
        ],
      ),
      onTap: (){
        clickDelegate?.didSelectCell(section: section, clickType: 1, data: model);
      },
    );
  }

  /// 显示更多，只有商品数量多余三个时候显示
  Widget _moreView(){
    if (model.isShowMore){
      return XFSTextButton.icon(
        onPressed: (){
          clickDelegate.didSelectCell(section: section, clickType: 2, data: model);
        },
        gap: 3,
        height: 30,
        direction: XFSTextButtonIconTextDirection.textLIconR,
        icon: Image.asset(model.isExpand ? R.orderArrowUp : R.orderArrowDown, width: 10, height: 10,),
        title: model.isExpand ? '收起' : '更多',
        textColor: Config.color333333,
        fontSize: 12,
      );
    }
    return SizedBox(height: 0,);
  }

  /// 总金额
  Widget _totalAmountView(){

    var price = XFSNumUtil.getNumStringByValueDouble(model.paid_amount, 2);
    var priceList = price.split('.');

    return Container(
      padding: EdgeInsets.only(right: 20, left: 8),
      alignment: Alignment.centerRight,
      height: 60,
      child: RichText(
        text: TextSpan(
            text: '共${model.order_total_count.toInt()}种商品  总金额：',
            style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(text: '￥', style: TextStyle(fontSize: 13, color: Config.colorFFA200)),
              TextSpan(text: '${priceList[0]}.', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Config.colorFFA200)),
              TextSpan(text: '${priceList[1]}', style: TextStyle(fontSize: 13, color: Config.colorFFA200, fontWeight: FontWeight.w600)),
            ]
        ),
      ),
    );
  }

  Widget _bottomView(){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 8, top: 12, bottom: 12),
      child: Wrap(
        spacing: 10,
        children: _buildButton(),
      ),
    );
  }

  /// 构建底部按钮.根据订单状态，权限等组合
  List<Widget> _buildButton(){
    List<Widget> titles = List();

    /// 去支付按钮
    if (XFSOrderStatusWithButton.hasPayButton(model.order_status, model.paid_button_show, model.hasSettleAuth())){
      if ((model.paid_type == 1301 || model.paid_type == 1401)) {
        titles.add(_button('去确认', Config.color999999));
      }else{
        titles.add(_button('去支付', Config.color999999));
      }
    }

    /// 取货二维码和验证码
    if (XFSOrderStatusWithButton.hasQRCodeButton(model.order_status, model.cancle_apply_show, model.paid_type, model.sent_type, model.hasBuyAuth())){
      titles.add(_button('取货二维码', Config.color999999));
      titles.add(_button('取货验证码', Config.color999999));
    }

    /// 审核按钮
    if (XFSOrderStatusWithButton.hasApproveButton(model.order_status, model.audit_button_show, model.hasApproveAuth())){
      titles.add(_button('去审批', Config.color999999));
    }

    /// 去确认
    if (XFSOrderStatusWithButton.hasGoConfirmButton(model.order_status, model.paid_button_show, model.paid_type, model.hasSettleAuth())){
      titles.add(_button('去确认', Config.color999999));
    }

    /// 删除订单
    if (XFSOrderStatusWithButton.hasDeleteButton(model.order_status)){
      titles.add(_button('删除订单', Config.color999999));
    }

    /// 退货/维修
    if (XFSOrderStatusWithButton.hasReturnButton(model.order_status, model.customer_id, model.hasBuyAuth())){
      if (model.is_show){
        titles.add(_button('申请退货', Config.color999999));
        titles.add(_button('申请维修', Config.color999999));
      }else{
        titles.add(_button('申请退货', Config.colorD7D7D7, enble: false, textColor: Config.colorD7D7D7));
        titles.add(_button('申请维修', Config.colorD7D7D7, enble: false, textColor: Config.colorD7D7D7));
      }
    }

    /// 确认收货
    if (XFSOrderStatusWithButton.hasConfurmOrderButton(model.order_status, model.final_sent_type, model.hasBuyAuth())){
      titles.add(_button('确认收货', Config.color999999));
    }

    /// 取消按钮
    if (XFSOrderStatusWithButton.hasCancelButton(model.order_status, model.cancle_apply_show, model.hasBuyAuth())){
      titles.add(_button('取消订单', Config.color999999));
    }

    /// 再次购买
    if (XFSOrderStatusWithButton.hasBuyAgainButton(model.order_status, model.buy_again_button, model.canBuyAgain(), model.hasBuyAuth())){
      titles.add(_button('再次购买', Config.colorFFA200, textColor: Config.colorFFA200),);
    }
    return titles;
  }


  Widget _button(String title, Color borderColor,{Color textColor=Config.color333333, bool enble=true,}){
    return XFSContainer(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: borderColor, width: 1),
      padding: EdgeInsets.all(5),
      onTap: (){
        if (enble){
          clickDelegate?.didSelectCell(section: section, clickType: 100, data: model, data1: title);
        }
      },
      child: XFSTextView(
        title,
        textColor: textColor,
        fontSize: 12,
      ),
    );
  }
}
