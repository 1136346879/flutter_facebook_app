import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

/// 自定义异常
class AppException implements Exception {
  final String message;
  final String code;
  final Map resposeData;

  AppException([
    this.code,
    this.message,
    this.resposeData,
  ]);

  String toString() {
    return "$code$message";
  }

  factory AppException.create(DioError error) {

    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return BadRequestException('-1', "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return BadRequestException('-1', "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return BadRequestException('-1', "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return BadRequestException('-1', "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
//             String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 202:
                {
                  return BadRequestException('$errCode', "审批记录表,查询，数据库中无记录");
                }
                break;
              case 400:
                {
                  return BadRequestException('$errCode', "请求语法错误");
                }
                break;
              case 401:
                {
                  return UnauthorisedException('$errCode', "没有权限");
                }
                break;
              case 403:
                {
                  return UnauthorisedException('$errCode', "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return UnauthorisedException('$errCode', "无法连接服务器");
                }
                break;
              case 405:
                {
                  return UnauthorisedException('$errCode', "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return UnauthorisedException('$errCode', "服务器内部错误");
                }
                break;
              case 502:
                {
                  return UnauthorisedException('$errCode', "无效的请求");
                }
                break;
              case 503:
                {
                  return UnauthorisedException('$errCode', "服务器挂了");
                }
                break;
              case 505:
                {
                  return UnauthorisedException('$errCode', "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return AppException('$errCode', error.response.statusMessage);
                }
            }
          } on Exception catch (_) {
            return AppException('-1', "未知错误");
          }
        }
        break;
      default:
        {
          if(error.error is String){
            return AppException('-1', error.error,);
          }
          else if(error.error is AppException){
            return error.error;
          }
          else{
            return AppException('-1', "未知错误");
          }
        }
    }
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([String code, String message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([String code, String message]) : super(code, message);
}
