import 'package:flutter/material.dart';
import 'package:flutter_facebook/models/banner_model.dart';
import 'package:flutter_facebook/subject/subject_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommontBanner extends StatelessWidget {
  final List<BannerModelData> swiperDataList;

  CommontBanner({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      child: swiperDataList.isEmpty ?
          Text("加载中。。。")
          : Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]?.picUrl}",
              fit: BoxFit.fill);
        },
        onTap: (index) {
         Fluttertoast.showToast(msg:swiperDataList[index]?.picTitle);
         SubectListPage.pushName(context);
        },
        itemCount: swiperDataList?.length ?? 0,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
