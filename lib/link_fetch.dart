import 'dart:async';

import 'package:flutter/services.dart';

class LinkFetch {
  static const MethodChannel _channel = MethodChannel("link_fetch");

  // 不过滤任何信息，直接获取消息体
  static Future<Map<String, dynamic>> linkFetch(
      {required String url, String encodeUrl = "true"}) async {
    try {
      final result = await _channel.invokeMethod(
          "linkFetch", <String, dynamic>{"url": url, "encodeUrl": encodeUrl});
      return <String, dynamic>{
        'data': result['data'] ?? Uint8List(0),
        'content-type': result['content-type'] ?? "",
        "error": result['error'] ?? "",
        'status_code': result['status_code'] ?? "",
        'url': result['url'] ?? "",
      };
    } catch (e) {
      print(e.toString());
    }
    return {};
  }

  // 仅获取头文件
  static Future<Map<String, String>> linkFetchHead(
      {required String url, String encodeUrl = "true"}) async {
    try {
      final result = await _channel.invokeMethod("linkFetchHead",
          <String, dynamic>{"url": url, "encodeUrl": encodeUrl});
      final formatResult = <String, String>{};
      result.forEach((key, value) {
        formatResult[key.toString().toLowerCase()] =
            value.toString().toLowerCase();
      });
      return formatResult;
    } catch (e) {
      print(e.toString());
    }
    return {};
  }
}
