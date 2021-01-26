import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook/address/xfs_address_model.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'get_address_controller.dart';

///
///       创建时间：2021/1/26
///       修改人  ：zhangyan
///       描述    ： GETX 列表编写
/// 
class GetAddressListPage extends XFSGetBaseListPage {
  String addressId;

  GetAddressListPage({this.addressId});
  static pushName (BuildContext context,{String addressId}){
    Navigator.pushNamed(context, XFSAppRouteConfigure.getAddressListPage,arguments: addressId).then((value) => {
      Fluttertoast.showToast(msg: "回传回数据---$value")
    });
  }
  @override
  XFSGetBaseListPageState<XFSGetBaseListPage, Object, XFSBaseListPageController> getState() => _GetAddressListPageState();

}

class _GetAddressListPageState extends XFSGetBaseListPageState<GetAddressListPage, XFSAddressModel, GetAddressController> {


  num pageNum = 1;
  String title = "自定义  buildAppBarTitleView";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  bool get isShowHeader =>true ;
  @override
  String get naviTitle => "地址列表";


  @override
  Widget buildTopView(List<XFSAddressModel> object) {

  return  XFSContainer(
    padding: EdgeInsets.all(10),
    backgroundColor: Colors.black,
    child: Obx(()=> Text('${baseC.count}',style:TextStyle (color: Colors.white,))),
    onTap: (){
      Fluttertoast.showToast(msg: 'dianji');
      baseC.increment();
      },
  );
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
                        baseC.removeElements(entity);
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
  void onLoadMore() {
  baseC.increment();
    loadMore();
  }

  @override
  void onRefresh() {
    baseC.increment();
   refresh();
  }
   @override
   GetAddressController initController() {
   return GetAddressController();
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

  void refresh() {
    var map = new Map<String, dynamic>();
    map['pageNum'] = 1;
    map['pageSize'] = 10;
    map['type'] = 10;
    map['memberId'] = 4717;//T4
    map['member_id'] = 4717;
    baseC.refreshAddressData(params: map);
    pageNum++;
  }

  void loadMore() {
    var map = new Map<String, dynamic>();
    map['pageNum'] = pageNum;
    map['pageSize'] = 10;
    map['type'] = 10;
    map['memberId'] = 4717;//T4
    map['member_id'] = 4717;
    baseC.refreshAddressData(params: map);
  }
}







      