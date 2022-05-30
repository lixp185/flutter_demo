/// code : 0
/// message : "success"
/// sid : "tts000eb834@dx18113f02d1d6f2c902"
/// data : {"audio":""}

class XfRes {
  XfRes({
      int? code, 
      String? message, 
      String? sid, 
      Data? data,}){
    _code = code;
    _message = message;
    _sid = sid;
    _data = data;
}

  XfRes.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _sid = json['sid'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _message;
  String? _sid;
  Data? _data;

  int? get code => _code;
  String? get message => _message;
  String? get sid => _sid;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['sid'] = _sid;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// audio : ""

class Data {
  Data({
      String? audio,}){
    _audio = audio;
}

  Data.fromJson(dynamic json) {
    _audio = json['audio'];
  }
  String? _audio;

  String? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['audio'] = _audio;
    return map;
  }

}