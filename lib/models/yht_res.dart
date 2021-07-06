/// code : 2001
/// message : "其他错误：Required String parameter 'username' is not present"
/// data : "Required String parameter 'username' is not present"
/// method : "GET"
/// url : "http://yhtapi.instrument.com.cn/v1/user/sign"

class YhtRes {
  int _code;
  String _message;
  String _data;
  String _method;
  String _url;

  int get code => _code;
  String get message => _message;
  String get data => _data;
  String get method => _method;
  String get url => _url;

  YhtRes({
      int code, 
      String message, 
      String data, 
      String method, 
      String url}){
    _code = code;
    _message = message;
    _data = data;
    _method = method;
    _url = url;
}

  YhtRes.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
    _data = json["data"];
    _method = json["method"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    map["data"] = _data;
    map["method"] = _method;
    map["url"] = _url;
    return map;
  }

}