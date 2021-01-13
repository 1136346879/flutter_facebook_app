import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:flutter_facebook/xfs_self_raise/xfs_self_raise_address_model.dart';

class XFSSelfItemBuildWidget extends StatelessWidget {
  final xfsSelfRaiseSearchModel model;
  final bool storeList;//门店列表搜索点击
  final bool listItem;//门店列表直接点击

  const XFSSelfItemBuildWidget(
      {Key key, this.model, this.storeList = false, this.listItem=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XFSContainer(
        backgroundColor:
            model.isSelected ?? false ? Config.colorfdf2e9 : Colors.white,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: model.isSelected ? Config.colorFFA200 : Colors.white,
            width: 1),
        padding: EdgeInsets.all(10),
        onTap: () {
          // if (storeList) {
            if (listItem) {///门店列表点击直接返回原生
              Navigator.pop(context, model);
            } else {//门店列表--搜索点击先返回 门店列表
              Navigator.pop(context, model.ship_add_id);
            }
          // } else {
          //   if (listItem) {///门店列表点击直接返回原生
          //     XFSCommonUtils.goBackNative(argument: model.toJson());
          //   } else {///自提点列表 搜索 点击返回原生自提点列表
          //     XFSCommonUtils.goBackNative(
          //         argument: double.tryParse(model.ship_add_id).toInt());
          //   }
          // }
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: XFSText.container(
                    model.add_alias,
                    padding: EdgeInsets.all(10),
                    fontSize: 14,
                    textColor: Config.color333333,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(
                  visible: model.distance != null && model.distance != "null" ?? false,
                  child: XFSText.container(
                    getDistance(model.distance),
                    height: 25,
                    border: Border.all(color: Config.colorD3D3D3, width: 1),
                    padding: EdgeInsets.all(4),
                    fontSize: 12,
                    textColor: Config.color999999,
                  ),
                ),
                Visibility(
                  visible: model.isLastAddress ?? false,
                  child: XFSText.container(
                    "上次使用",
                    height: 25,
                    border: Border.all(color: Config.colorFFA200, width: 1),
                    backgroudColor: Config.colorFFA200,
                    padding: EdgeInsets.all(4),
                    fontSize: 12,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
              color: Config.colorCCCCCC,
            ),
            XFSText.container(
              "地址： ${getContent(model)}",
              padding: EdgeInsets.only(top: 10, left: 10),
              fontSize: 12,
              textColor: Config.color666666,
            ),
            Row(
              children: [
                const XFSText.container(
                  '联系方式: ',
                  padding: EdgeInsets.only(left: 10),
                  fontSize: 12,
                  textColor: Config.color333333,
                ),
                XFSText.container(
                  "${model.office_phone}",
                  fontSize: 12,
                  textColor: Config.color2391EA,
                  onTap: () {
                    XFSCommonUtils.callPhone("${model.office_phone}");
                  },
                ),
                Flexible(flex: 1, child: XFSContainer()),
                XFSTextButton.icon(
                  height: 16,
                  title: "",
                  direction: XFSTextButtonIconTextDirection.textLIconR,
                  icon:ImageIcon(AssetImage(R.phoneCall),  color: Config.color2391EA),
                  onPressed: () {
                    XFSCommonUtils.callPhone("${model.office_phone}");
                  },
                )
              ],
            ),
          ],
        ));
  }

  String getDistance(String distance) {
    if ("null" == distance || distance.isNullOrEmpty()) return "";
    var distanceTransfrom = double.tryParse(distance);
    if (distanceTransfrom < 1000) {
      return '${distanceTransfrom.toInt()}m';
    } else {
      var distanceDou = distanceTransfrom / 1000;
      return "${distanceDou.toStringAsFixed(1)}km"; //四舍五入保留一位
    }
  }

  ///拼接详情地址
  getContent(xfsSelfRaiseSearchModel model) {
    String provinceName = model.provinceName ?? "";
    String cityName = model.cityName ?? "";
    String areaName = model.areaName ?? "";
    String streetName = model.streetName ?? "";
    String detail_address = model.detail_address ?? "";
    return "$provinceName$cityName$areaName$streetName$detail_address";
  }
}
