import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/address/xfs_address_list_presenter.dart';
import 'package:flutter_facebook/address/xfs_address_model.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/config/xfs_r.dart';
import 'package:flutter_facebook/router/xfs_route_configure.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/base/xfs_base_list_page.dart';
import 'package:xfs_flutter_utils/base/xfs_base_presenter.dart';
import 'package:xfs_flutter_utils/base/xfs_base_view.dart';
import 'package:xfs_flutter_utils/define/xfs_config.dart';
import 'package:xfs_flutter_utils/widgets/xfs_container.dart';
import 'package:xfs_flutter_utils/widgets/xfs_inkwell.dart';
import 'package:xfs_flutter_utils/widgets/xfs_text.dart';




class XFSAddressListPage extends XFSBaseListPage {
  String addressId;

  XFSAddressListPage({this.addressId});
  static pushName (BuildContext context,{String addressId}){
    Navigator.pushNamed(context, XFSAppRouteConfigure.xfsAddressListPage,arguments: addressId).then((value) => {
      Fluttertoast.showToast(msg: "回传回数据---$value")
    });
  }

  @override
  XFSBaseListPageState<XFSBaseListPage, Object, XFSBasePresenter<XFSBaseView>>
      getState() {
    return _AddressListPageState();
  }
}

class _AddressListPageState extends XFSBaseListPageState<XFSAddressListPage,
    XFSAddressModel, XFSAddressListPresenter>   {

  num pageNum = 1;
  @override
  void initState() {
    super.initState();
    configureRefreshPageWithState(false, false);
    var map = new Map<String, dynamic>();
    map['pageNum'] = 1;
    map['pageSize'] = 10;
    map['type'] = 10;
    // map['memberId'] = 1047;
    map['memberId'] = 42;
    // map['memberId'] = 11;
    map['member_id'] = 42;
    presenter.refreshData(params: map);
    pageNum++;
  }
  @override
  Widget buildItem(XFSAddressModel entity, int index) {
    return Dismissible(
      key: Key(UniqueKey().toString()),
      // onDismissed: (direction){
      //   presenter.removeElements(entity);
      // },
      confirmDismiss: (DismissDirection direction) async {
        final bool res = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  "注意",
                  style: TextStyle(
                      fontSize: 16, color: Colors.red),
                ),
                content: const Text("您是否要删除这个地址呢？"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        presenter.removeElements(entity);
                      },
                      child: Text(
                        "是的",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green),
                      )),
                  FlatButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange),
                    ),
                  )
                ],
              );
            });
        return res;
      },
      background: Container(
        padding: const EdgeInsets.only(right: 30),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Text(
          '滑动删除地址',
          style:
          TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      child: XFSInkWell(
          child: XFSContainer(
              backgroundColor: entity.isSelected??false ? Config.colorfdf2e9 : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: entity.isSelected??false ? Config.colorFFA200 : Colors.white, width: 1),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  XFSText.normal(
                    '${entity.addressPersonList != null?entity.addressPersonList[0]?.receiverName:"--"}   ${entity.addressPersonList != null?entity.addressPersonList[0]?.mobile:"--"}',),
                  Row(
                    children: [
                      Visibility(
                          // visible: entity.isDefault ==1,
                          visible: true,
                          child: const XFSText.container('默认',margin:EdgeInsets.only(top:10,bottom:10,right: 30),padding:EdgeInsets.only(left: 10,right: 10,top:4,bottom: 4),borderRadius: BorderRadius.all(Radius.circular(4.0)),textColor:Colors.white,backgroudColor: Config.dark_button_disabled,)),
                  Visibility(
                      // visible: entity.limitLine == 10,
                      visible: true,
                      child: XFSText.container('限行',margin:EdgeInsets.only(top:10,bottom:10,right: 30),padding:EdgeInsets.only(left: 10,right: 10,top:4,bottom: 4),borderRadius: BorderRadius.all(Radius.circular(4.0)),backgroudColor:Config.colorFFA200,textColor:Colors.white )),
                    ],
                  ),
                  Image.asset(R.addressLine,width: MediaQuery.of(context).size.width,height: 2),
                  XFSText.container("${getContent(entity)}",margin: EdgeInsets.only(top: 10),)
                ],
              )
          ),
        onTap: (){
          Fluttertoast.showToast(msg: '${entity.detailAddress}--$index');
        },
      ),
    );
  }


  @override
  XFSAddressListPresenter initPresenter() {
    return XFSAddressListPresenter(this);
  }

  @override
  String get naviTitle => "your address";

  @override
  void onLoadMore() {
    super.onLoadMore();
    var map = new Map<String, dynamic>();
    map['pageNum'] = pageNum;
    map['pageSize'] = 10;
    map['type'] = 10;
    // map['memberId'] = 1047;
    map['memberId'] = 42;
    // map['memberId'] = 11;
    map['member_id'] = 42;
    presenter.refreshData(params: map);

  }
  @override
  void onRefresh() {
    super.onRefresh();
    var map = new Map<String, dynamic>();
    pageNum = 1;
    map['pageNum'] = 1;
    map['pageSize'] = 10;
    map['type'] = 10;
    // map['memberId'] = 1047;
    map['memberId'] = 42;
    // map['memberId'] = 11;
    map['member_id'] = 42;
    presenter.refreshData(params: map);
    pageNum++;

  }

  ///拼接详情地址
  getContent(XFSAddressModel model) {
    String provinceName = model.provinceName ?? "";
    String cityName = model.cityName ?? "";
    String areaName = model.areaName ?? "";
    String streetName = model.streetName ?? "";
    String detail_address = model.detailAddress ?? "";
    return "$provinceName$cityName$areaName$streetName$detail_address";
  }

}

