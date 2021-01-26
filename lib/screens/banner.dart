import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/address/get_address_list_page.dart';
import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfs_flutter_utils/xfs_flutter_utils.dart';

///
///       创建时间：2021/1/7
///       修改人  ：zhangyan
///       描述    ：
///
class CategoryBanner extends StatelessWidget {
  final List<BannerModelData> swiperDataList;

  CategoryBanner({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: EdgeInsets.all(20),
      height: 200,
      child: swiperDataList.isEmpty
          ? Text("加载中。。。")
          : Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        XFSTextButton.icon(
                          width: 100,
                          height: 80,
                          icon: Icon(Icons.ac_unit),
                          onPressed: () {
                            Fluttertoast.showToast(msg: '点击icon1');
                            GetAddressListPage.pushName(context);
                          },
                        ),
                        XFSTextButton.icon(
                            onPressed: () {
                              Fluttertoast.showToast(msg: '点击icon2');
                            },
                            width: 100,
                            height: 80,
                            icon: Icon(Icons.add)),
                      ],
                    ),
                    Row(
                      children: [
                        XFSTextButton.icon(
                          width: 100,
                          height: 80,
                          icon: Icon(Icons.eco),
                          onPressed: () {
                            Fluttertoast.showToast(msg: '点击icon3');
                          },
                        ),
                        XFSTextButton.icon(
                            onPressed: () {
                              Fluttertoast.showToast(msg: '点击icon4');
                            },
                            width: 100,
                            height: 80,
                            icon: Icon(Icons.offline_bolt)),
                      ],
                    ),
                  ],
                );
              },
              // onTap: (index) {
              //   Fluttertoast.showToast(msg:swiperDataList[index]?.picTitle);
              //   SubectListPage.pushName(context);
              // },
              itemCount: 2,
              pagination: new SwiperPagination(builder: SwiperPagination.rect),
              autoplay: false,
            ),
    );
  }
}
