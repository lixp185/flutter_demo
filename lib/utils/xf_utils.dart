import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

/// 讯飞鉴权
final df = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");

///如果项目中使用了国际化,请约束DateFormat使用英文样式
// final df = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'","en");

///获取鉴权地址
String getAuthUrl(String host, String apiKey, String apiSecret) {
  // var date = df.format(DateTime.now());
  var date = "Mon, 30 May 2022 14:50:53 GMT";

  final signatureOrigin = 'host: $host\ndate: $date\nGET /v2/tts HTTP/1.1';
  final signature = _hmacSha256Base64(signatureOrigin, apiSecret);
  final authorizationOrigin =
      'api_key="$apiKey", algorithm="hmac-sha256", headers="host date request-line", signature="$signature"';
  final authorization = base64.encode(authorizationOrigin.codeUnits);
  //对日期进行uri编码
  date = Uri.encodeComponent(date);
  final url =
      'wss://$host/v2/tts?authorization=$authorization&date=$date&host=$host';
  print("鉴权 = $url");
  return url;
}

///hmacSha256加密后再进行base64编码
String _hmacSha256Base64(String message, String secret) {
  List<int> messageBytes = utf8.encode(message);
  List<int> secretBytes = utf8.encode(secret);
  Hmac hmac = Hmac(sha256, secretBytes);
  Digest digest = hmac.convert(messageBytes);
  return base64.encode(digest.bytes);
}


///wss://tts-api.xfyun.cn/v2/tts?
///authorization=YXBpX2tleT0iNDQ1ZjU3MDI5MTFlYzA0Y2ZjOTE1NWUxMzUwYjJhNTMiLCBhbGdvcml0aG09ImhtYWMtc2hhMjU2IiwgaGVhZGVycz0iaG9zdCBkYXRlIHJlcXVlc3QtbGluZSIsIHNpZ25hdHVyZT0id0dZYnYzRHBaaitvNHZSNzdnMDhQcU5NNTVuSkVBQ0hiaUdKVDMvVTFBQT0i&date=Mon%2C%2030%20May%202022%2014%3A50%3A53%20GMT&host=tts-api.xfyun.cn

///wss://tts-api.xfyun.cn/v2/tts?
///authorization=YXBpX2tleT0iNDQ1ZjU3MDI5MTFlYzA0Y2ZjOTE1NWUxMzUwYjJhNTMiLCBhbGdvcml0aG09ImhtYWMtc2hhMjU2IiwgaGVhZGVycz0iaG9zdCBkYXRlIHJlcXVlc3QtbGluZSIsIHNpZ25hdHVyZT0id0dZYnYzRHBaaitvNHZSNzdnMDhQcU5NNTVuSkVBQ0hiaUdKVDMvVTFBQT0i&date=Mon,%2030%20May%202022%2014:50:53%20GMT&host=tts-api.xfyun.cn
