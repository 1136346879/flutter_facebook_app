import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_r.dart';
import 'package:xfs_flutter_utils/extension/xfs_extension.dart';

/// Created by liuwei
/// on 2020-09-07
/// page xfs_img_loader

enum XFSLoadImagePlaceType{
  /// 加载头像
  HEADER,
  /// 默认加载指示器
  NORMAL,
  /// 自定义
  CUSTOMER,
}

enum XFSImageUrlStyle{

  style150,

  style200,

  style350,
}

class XFSNetImageLoader {

  /// 加载网络图片
  /// [url] 网络图片地址
  /// [width] 宽
  /// [height] 高
  /// [fit] [BoxFit]图片显示样式
  /// [placeType] 默认加载图片显示
  /// [placeholder] 自定义
  /// [errorWidget] 加载错误显示
  static Widget loadNetImage({
    @required String url,
    double width,
    double height,
    BoxFit fit=BoxFit.cover,
    XFSLoadImagePlaceType placeType = XFSLoadImagePlaceType.NORMAL,
    XFSImageUrlStyle style = XFSImageUrlStyle.style150,
    Widget placeholder,
    Widget errorWidget,
  }){

    /// 如果url为空则直接显示默认加载图片
    if (url.isNullOrEmpty()){
      return Image.asset(R.normalImage,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (placeType == XFSLoadImagePlaceType.HEADER) {
      placeholder = Image.asset(R.normalImage, fit: BoxFit.cover,
        width: width,
        height: height,);
    }
    else if (placeType == XFSLoadImagePlaceType.NORMAL) {
      placeholder = CircularProgressIndicator();
    }
    else if (placeType == XFSLoadImagePlaceType.CUSTOMER) {
      /// 默认的替换图片
      if (placeholder == null) {
        placeholder = CircularProgressIndicator();
      }
    }

    /// 默认错误图片
    if (errorWidget == null) {
      if (placeType == XFSLoadImagePlaceType.HEADER){
        errorWidget = Image.asset(R.normalImage, fit: BoxFit.cover, width: width, height: height,);
      }else{
        errorWidget = Image.asset(R.normalImage, fit: BoxFit.cover, width: width, height: height,);
      }
    }

    String urlString;
    if (url.isNotNullOrEmpty()){

      switch (style){

        case XFSImageUrlStyle.style150:
          urlString = url.replaceAll('marking_text', 'style150');

          break;
        case XFSImageUrlStyle.style200:
          urlString = url.replaceAll('marking_text', 'style200');
          break;
        case XFSImageUrlStyle.style350:
          urlString = url.replaceAll('marking_text', 'style350');
          break;
      }
    }else{
      urlString = url;
    }


    return FadeInImage.assetNetwork(
      placeholder: R.normalImage,
      image: urlString,
      fit: fit,
      width: width,
      height: height,
    );
    return Image.network(urlString,
      fit: fit,
      width: width,
      height: height,
    );
    return CachedNetworkImage(
      imageUrl: urlString,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
