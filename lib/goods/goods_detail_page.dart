import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/models/GoodsDetailModel.dart';
import 'package:flutter_facebook/widgets/banner/pagination.dart';
import 'package:flutter_facebook/widgets/common_line_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

import 'goods_detail_presenter.dart';

class GoodsDetailPage extends XFSBasePage {
  final int arguments;

  GoodsDetailPage({this.arguments});

  static push(BuildContext context, {int arguments}) {
    Navigator.pushNamed(context, XFSAppRouteConfigure.goodsDetailPage,
            arguments: arguments)
        .then((value) {});
  }

  @override
  XFSBasePageState getState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends XFSBasePageState<GoodsDetailPage,
    List<GoodsDetailModel>, GoodsDetailPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.getGoodsDetialData(spuId: widget.arguments);
  }

  @override
  GoodsDetailPresenter initPresenter() {
    return GoodsDetailPresenter(this);
  }

  @override
  List<Widget> actions() {
    return [
      XFSTextButton.icon(
        icon: Icon(
          Icons.share,
          color: Colors.white,
        ),
        width: 6,
        onPressed: () {
          Fluttertoast.showToast(msg: '分享');
        },
      ),
    ];
  }

  @override
  Widget buildAppBarTitleView() {
    return XFSContainer(
      child: XFSText('商品详情页'),
    );
  }

  @override
  Widget buildWidget(
      BuildContext context, List<GoodsDetailModel> listGoodsDetailModel) {
    return listGoodsDetailModel.isNullOrEmpty()
        ? XFSText('加载中')
        : XFSContainer(
      backgroundColor: Colors.white,
            child: Column(
              children: [
                Pagination(images: listGoodsDetailModel[0].images),
                XFSText(
                  '${listGoodsDetailModel[0].skuName} ${listGoodsDetailModel[0].color ?? ""} ${listGoodsDetailModel[0].specifications} ',
                  padding: EdgeInsets.all(10),
                  fontWeight: FontWeight.bold,
                ),
                Visibility(
                  visible: listGoodsDetailModel[0].subtitile.isNotEmpty,
                  child: XFSText(
                    '${listGoodsDetailModel[0].subtitile} ',
                    textColor: Config.color666666,
                    fontSize: 12,
                    padding: EdgeInsets.only(bottom: 10, left: 10),
                  ),
                ),
                Row(
                  children: [
                    XFSText(
                      '签约价：${listGoodsDetailModel[0].salePrice}/${listGoodsDetailModel[0].unit}',
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                      textColor: Colors.orange,
                    ),
                    XFSText(
                    '售价：￥${listGoodsDetailModel[0].retailPrice}/${listGoodsDetailModel[0].unit}',
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ],
                ),
                CommonLineView(height: 20,color: Config.colorF5F5F5,),
                XFSContainer(
                    child: Row(
                      children: [
                        XFSTextButton.icon(icon: Icon(Icons.wysiwyg,color: Colors.orange,size: 50,),title: '规格',direction:XFSTextButtonIconTextDirection.textBIconT,),
                        CommonLineView(height: 60,color: Config.colorF5F5F5,width: 1,),
                        XFSText("请选择规格",padding: EdgeInsets.all(10),),
                      ],
                    )),
                CommonLineView(height: 1,color: Config.colorF5F5F5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    XFSTextButton.icon(icon:Icon(Icons.location_on,color: Colors.orange,),title:'配送区域选择：',direction: XFSTextButtonIconTextDirection.textLIconR,),
                    XFSText('请选择城市',textColor: Colors.orange,),
                  ],
                ),
                CommonLineView(height: 20,color: Config.colorF5F5F5,),
                Expanded(
                  child: ListView.builder(itemBuilder:(ctx,index){
                    return XFSText('规格:${listGoodsDetailModel[index].color}/${listGoodsDetailModel[index].specifications}/${listGoodsDetailModel[index].salePrice}');
                  },
                    itemCount: 5,
                  ),
                )
              ],
            ),
          );
  }
}
