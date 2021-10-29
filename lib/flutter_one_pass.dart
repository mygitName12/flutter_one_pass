import 'dart:async';

import 'package:flutter/services.dart';

/// flutter_one_pass
/// author: zrong
/// email: zengrong27@gmail.com
/// https://zrong.life

MethodChannel _channel = MethodChannel('life.zrong/flutter_one_pass')
  ..setMethodCallHandler(_handler);

StreamController _responseController = new StreamController.broadcast();

Stream get response => _responseController.stream;

/// 初始化sdk
/// [appId] appId
Future<bool> init({required String appId}) async {
  bool isInit = await _channel.invokeMethod("init", { "appId": appId });
  return isInit;
}

/// 获取本地最近一条缓存的手机号
Future<String> get getCachedNumber async {
  String number = await _channel.invokeMethod("getCachedNumber");
  return number;
}

/// 获取匹配的手机号列表
/// [number] 匹配的手机号码字符串 eg: 888, 133, 3898
Future<List<String>> getCachedNumbers({required String number}) async {
  List<String> numbers = await _channel.invokeMethod("getCachedNumbers", {"number": number});
  return numbers;
}

/// 验证手机号
/// [phone]待验证的手机号
/// [cacheNumber]是否缓存手机号
checkMobile({required String phone, bool cacheNumber = true}) async {
  await _channel.invokeMethod("checkMobile", {
    "phone": phone,
    "cacheNumber": cacheNumber
  });
}

/// 释放引用
Future<bool> destroy() async {
  bool isDestroy = await _channel.invokeMethod("destroy");
  return isDestroy;
}

/// 添加监听
/// [methodCall]
/// 本机号码验证结果返回
Future<dynamic> _handler(MethodCall methodCall) {
  if (methodCall.method == "onCheckResponse") {
    _responseController.add(CheckResultResponse.fromJson(Map<String, dynamic>.from(methodCall.arguments)));
  }
  return Future.value(true);
}

class CheckResultResponse {
  final int errorCode;
  final String process_id;
  final String accesscode;
  final String phone;
  final String errorInfo;

  CheckResultResponse({this.errorCode = 0, this.process_id = "", this.accesscode = "", this.phone = "", this.errorInfo = ""});

  factory CheckResultResponse.fromJson(Map<String, dynamic> json) {
    return CheckResultResponse(
      errorCode: int.parse("${json['error_code']}"),
      process_id: json['process_id'],
      accesscode: json['accesscode'],
      phone: json['phone'],
      errorInfo: json['error_info']
    );
  }
}