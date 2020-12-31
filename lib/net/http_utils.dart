import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xfs_flutter_utils/base/xfs_base_entity.dart';
import 'package:xfs_flutter_utils/net/xfs_http.dart';
import 'app_exceptions.dart';
import 'http_code.dart';
import 'xfs_app_network_manage.dart';

typedef FailureBlock<T> = Function(T);
typedef SuccessBlock<T> = Function(T);

enum HttpMethod{
  POST,
  POSTQUERY,
  GET,
  PUT,
  DELETE,
  POST_FORM,
}

class HttpUtils {

  static void setHeaders(Map<String, dynamic> map) {
    Http.addHeaders(map);
  }

  static void cancelRequests() {
    Http().cancelRequests();
  }

  static Future<BaseEntity> getData(String path,String baseUrl, {
    @required HttpMethod httpMethod,
    Map<String, dynamic> params,
    CancelToken cancelToken,
    bool isParse = true,
  }) async {

    /// 判断是否有网络
    if (XFSAppNetworkStatusManager.networkStatu == ConnectivityResult.none){

      Future.delayed(Duration(milliseconds: 1), (){
        return Future.error(BaseEntity.notNetwork());
      });
    }

    BaseEntity model;

    var responseData;

    try {

      switch (httpMethod){

        case HttpMethod.POST:

          responseData = await Http().post(
            path, baseUrl ,
            data: params,
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POSTQUERY:
          responseData = await Http().post(
            path, baseUrl ,
            params: params,
            cancelToken: cancelToken,
          );

          break;
        case HttpMethod.GET:

          responseData = await Http().get(
            path,
            params: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.PUT:

          responseData = await Http().put(
            path,
            data: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.DELETE:

          responseData = await Http().delete(
            path,
            data: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.POST_FORM:
          responseData = await Http().postForm(
            path,
            formData: FormData.fromMap(params),
            cancelToken: cancelToken,
          );
          break;
      }

      if(responseData != null){
        if (isParse){
          model = BaseEntity.fromJson(responseData);
        } else {
          return Future.value(responseData);
        }
      }else{
        model = BaseEntity.error();
      }

      if(model.xfsCode == HttpCode.SUCCESS){
        return Future.value(model);
      }else{
        return Future.error(model);
      }

    }catch(error){
      if (!(error is DioError)){
        return Future.error(BaseEntity.error());
      }
      if (error.error is AppException){
        AppException appException = error.error;
        if (appException.resposeData != null){
          return Future.error(BaseEntity.fromJson(appException.resposeData));
        }
        return Future.error(BaseEntity(code: appException.code, message: appException.message));
      }
      return Future.error(BaseEntity(code: '-1', message: error.error.toString()));
    }
  }

  /// 获取网络数据
  /// [path] 路径
  /// [params] 上传参数
  /// [cancelToken] 取消token不传默认为dio统一token
  /// [httpMethod] 请求方法
  ///  /// [isParse] 是否解析
  /// [success] 成功回调
  /// [failure] 失败回调
  static getDataForCallback(
      String path,String baseUrl, {
        @required HttpMethod httpMethod,
        Map<String, dynamic> params,
        CancelToken cancelToken,
        bool isParse = true,
        SuccessBlock<BaseEntity> success,
        FailureBlock<BaseEntity> failure,
        SuccessBlock<dynamic> sucessJson,
      }) async{

    /// 判断是否有网络
    if (XFSAppNetworkStatusManager.networkStatu == ConnectivityResult.none){

      Future.delayed(Duration(milliseconds: 1), (){
        failure(BaseEntity.notNetwork());
      });
      return;
    }

    BaseEntity model;

    var responseData;

    try {

      switch (httpMethod){

        case HttpMethod.POST:

          responseData = await Http().post(
            path,baseUrl,
            data: params,
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POSTQUERY:
          responseData = await Http().post(
            path,baseUrl,
            params: params,
            cancelToken: cancelToken,
          );

          break;
        case HttpMethod.GET:

          responseData = await Http().get(
            path,
            params: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.PUT:

          responseData = await Http().put(
            path,
            data: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.DELETE:

          responseData = await Http().delete(
            path,
            data: params,
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.POST_FORM:
          responseData = await Http().postForm(
            path,
            formData: FormData.fromMap(params),
            cancelToken: cancelToken,
          );
          break;
      }

      if(responseData != null){
        if (isParse){
          model = BaseEntity.fromJson(responseData);
        } else {
          return sucessJson(responseData);
        }
      }else{
        model = BaseEntity.error();
      }

      if(model.xfsCode == HttpCode.SUCCESS){
        success(model);
      }else{
        failure(model);
      }

    }catch(error){

      if (!(error is DioError)){
        failure(BaseEntity.error());
        return;
      }
      if (error.error is AppException){
        AppException appException = error.error;
        if (appException.resposeData != null){
          failure(BaseEntity.fromJson(appException.resposeData));
          return;
        }
        failure(BaseEntity(code: appException.code, message: appException.message));
        return;
      }
      failure(BaseEntity(code: '-1', message: error.error.toString()));

    };
  }

  static Future uploadFile(
      String path, {
        FormData data,
        Options options,
        CancelToken cancelToken,
        ProgressCallback progressCallback
      }) async {
    return Http().uploadFile(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress:progressCallback
    );
  }

  static Future downloadFile(
      String path,String localPath,{
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
        ProgressCallback progressCallback
      }) async {

    return Http().downloadFile(
        path,
        localPath,
        params: params,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress:progressCallback
    );
  }

}
