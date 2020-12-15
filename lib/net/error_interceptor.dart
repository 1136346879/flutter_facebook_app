import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_facebook/net/xfs_common_channel_utils.dart';
import 'package:flutter_facebook/util/xfs_common_utils.dart';
import 'package:xfs_flutter_utils/net/xfs_http.dart';
import 'package:xfs_flutter_utils/extension/xfs_extension.dart';
import 'app_exceptions.dart';
import 'http_code.dart';


/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {


  @override
  Future onRequest(RequestOptions options) async{
    /// post方法拼接公参
    if (options.data is Object){

      if (options.method == 'POST'){
        if ((options.data as Object).isNotNullOrEmpty()){
          var data = await XFSCommonChannelUtils.getPublicParmas(options.data);
          data.forEach((key, value) {
            options.data[key] = value;
          });
        }
        else if ((options.queryParameters as Object).isNotNullOrEmpty()){
          var data = await XFSCommonChannelUtils.getPublicParmas(options.queryParameters);

          data.forEach((key, value) {
            options.queryParameters[key] = value;
          });
        }
        return options;
      }
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async{

    var data = response.data;
    if (data is String) {
      data = json.decode(data);
    }

    if (data is Map) {
      var code; // 表示如果data['ret']为空的话把 90赋值给errorCode

      if ((data['errorCode'] as Object).isNotNullOrEmpty()){
        code = data['errorCode'];
      }

      if ((data['code'] as Object).isNotNullOrEmpty()){
        code = data['code'];
      }

      String errorString = data['errorMessage']; // 表示如果data['ret']为空的话把 90赋值给errorCode

      if (code == null){
        return response;
      }

      if (code is String){
        return _responseResultCodeWithString(response, code, errorString);
      }
      else if (code is int){
        return _responseResultCodeWithInt(response, code, errorString);
      }
    }
    return response;
  }

  Future _responseResultCodeWithString(Response response, String code, String errorString) async{

    if (code == 'success' || code == '0') { // 正常
      response.data['xfsCode'] = HttpCode.SUCCESS;
      return response;
    }
    else {
      return dio.reject(AppException(code, errorString, response.data)); // 完成和终止请求/响应
    }
  }

  Future _responseResultCodeWithInt(Response response, int code, String errorString) async{
    if (code == 0) { // 正常
      response.data['xfsCode'] = HttpCode.SUCCESS;
      return response;
    }
    else {
      return dio.reject(AppException('$code', errorString, response.data)); // 完成和终止请求/响应
    }
  }

  @override
  Future onError(DioError err) {
    // error统一处理
    AppException appException = AppException.create(err);
    /// 1表示在订单列表加入购物车有的商品没有库存，不需要提示
    if (appException.code != '1'){
      XFSCommonUtils.showToast(msg: appException?.message??'未知错误');
    }
    return super.onError(DioError(error: appException));
  }
}
