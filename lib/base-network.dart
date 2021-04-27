import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gitpagetest/resp.dart';


enum RequestType { getMethod, postMethod }

class BaseNetwork  {
  getReq(String baseUrl, String url,
      {Map<String, String> params,
      Function(Resp) onDataCallBack,
      Function(Resp) errorCallBack,
      bool isReturnFuture = false}) async {
    if (isReturnFuture)
      return await _requestData(RequestType.getMethod,
          baseUrl: baseUrl,
          url: url,
          params: params,
          onDataCallBack: onDataCallBack,
          errorCallBack: errorCallBack,
          isReturnFuture: isReturnFuture);
    _requestData(RequestType.getMethod,
        baseUrl: baseUrl,
        url: url,
        params: params,
        onDataCallBack: onDataCallBack,
        errorCallBack: errorCallBack,
        isReturnFuture: isReturnFuture);
  }

  postReq(String baseUrl, String url,
      {Map<String, String> params,
      Map<String, dynamic> fd,
      Function(Resp) onDataCallBack,
      Function(Resp) errorCallBack,
      bool isReturnFuture = false,
      Map headers}) async {
    if (isReturnFuture)
      return await _requestData(
        RequestType.postMethod,
        url: url,
        baseUrl: baseUrl,
        params: params,
        fd: fd,
        onDataCallBack: onDataCallBack,
        errorCallBack: errorCallBack,
        isReturnFuture: isReturnFuture,
        headers: headers,
      );
    _requestData(
      RequestType.postMethod,
      baseUrl: baseUrl,
      url: url,
      params: params,
      fd: fd,
      onDataCallBack: onDataCallBack,
      errorCallBack: errorCallBack,
      isReturnFuture: isReturnFuture,
      headers: headers,
    );
  }

  _requestData(RequestType rt,
      {@required String baseUrl,
      @required String url,
      Map<String, String> params,
      Map<String, dynamic> fd,
      Function(Resp) onDataCallBack,
      Function(Resp) errorCallBack,
      bool isReturnFuture = false,
      Map headers}) async {
    BaseOptions options = BaseOptions();
    options.baseUrl = baseUrl;
    options.connectTimeout = 10000;
    options.receiveTimeout = 10000;
    if (headers != null) {
      options.headers = headers;
    }

    Dio dio = new Dio(options);

    try {
      Response response;
      if (rt == RequestType.getMethod) {
        if (params == null) {
          response = await dio.get(url);
        } else {
          response = await dio.get(url, queryParameters: params);
        }
      } else {
        if (params != null || fd != null) {
          response = await dio.post(
            url,
            data: fd,
            queryParameters: params,
          );
        } else {
          response = await dio.post(url);
        }
      }

      int statusCode = response.statusCode;

      Resp respOb = new Resp(); //data,message,err
      respOb.data = response.data;
      respOb.message = MsgState.data;
      if (isReturnFuture) return respOb;
      onDataCallBack(respOb);
      if (statusCode == 200) {
        //data
        respOb.data = response.data;
        respOb.message = MsgState.data;
        if (isReturnFuture) return respOb;
        onDataCallBack(respOb);
      } else {
        //error
        respOb.message = MsgState.error;
        respOb.data = "Error";
        if (isReturnFuture) return respOb;
        errorCallBack(respOb);
      }
    } catch (e) {
      Resp respOb = new Resp(); //data,message,err
      if (e is SocketException) {
        respOb.message = MsgState.error;
        respOb.data = "No Internet";
      } else {
        respOb.message = MsgState.error;
        respOb.data = "Error";
      }

      if (isReturnFuture) return respOb;
      errorCallBack(respOb);
    }
  }
}
