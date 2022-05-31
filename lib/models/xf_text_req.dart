/// common : {"app_id":"83836aa0"}
/// business : {"aue":"lame","tte":"UTF-8","ent":"intp65","vcn":"xiaoyan","volume":50,"pitch":50,"speed":50,"sfl":0,"auf":"","bgs":0,"reg":"0","rdn":"0"}
/// data : {"status":2,"text":"56uv5Y2I5a6J5bq3"}

class XfTextReq {
  XfTextReq({
      this.common, 
      this.business, 
      this.data,});

  XfTextReq.fromJson(dynamic json) {
    common = json['common'] != null ? Common.fromJson(json['common']) : null;
    business = json['business'] != null ? Business.fromJson(json['business']) : null;
    data = json['data'] != null ? DataReq.fromJson(json['data']) : null;
  }
  Common? common;
  Business? business;
  DataReq? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (common != null) {
      map['common'] = common?.toJson();
    }
    if (business != null) {
      map['business'] = business?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// status : 2
/// text : "56uv5Y2I5a6J5bq3"

class DataReq {
  DataReq({
      this.status, 
      this.text,});

  DataReq.fromJson(dynamic json) {
    status = json['status'];
    text = json['text'];
  }
  int? status;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['text'] = text;
    return map;
  }

}

/// aue : "lame"
/// tte : "UTF-8"
/// ent : "intp65"
/// vcn : "xiaoyan"
/// volume : 50
/// pitch : 50
/// speed : 50
/// sfl : 0
/// auf : ""
/// bgs : 0
/// reg : "0"
/// rdn : "0"


/// 参考： https://www.xfyun.cn/doc/tts/online_tts/API.html#%E6%8E%A5%E5%8F%A3%E8%B0%83%E7%94%A8%E6%B5%81%E7%A8%8B
class Business {
  Business({
      this.aue, 
      this.tte, 
      this.ent, 
      this.vcn, 
      this.volume, 
      this.pitch, 
      this.speed, 
      this.sfl, 
      this.auf, 
      this.bgs, 
      this.reg, 
      this.rdn,});

  Business.fromJson(dynamic json) {
    aue = json['aue'];
    tte = json['tte'];
    ent = json['ent'];
    vcn = json['vcn'];
    volume = json['volume'];
    pitch = json['pitch'];
    speed = json['speed'];
    sfl = json['sfl'];
    auf = json['auf'];
    bgs = json['bgs'];
    reg = json['reg'];
    rdn = json['rdn'];
  }
  String? aue;
  String? tte;
  String? ent;
  String? vcn;
  int? volume;
  int? pitch;
  int? speed;
  int? sfl;
  String? auf;
  int? bgs;
  String? reg;
  String? rdn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aue'] = aue;
    map['tte'] = tte;
    map['ent'] = ent;
    map['vcn'] = vcn;
    map['volume'] = volume;
    map['pitch'] = pitch;
    map['speed'] = speed;
    map['sfl'] = sfl;
    map['auf'] = auf;
    map['bgs'] = bgs;
    map['reg'] = reg;
    map['rdn'] = rdn;
    return map;
  }

}

/// app_id : "83836aa0"

class Common {
  Common({
      this.appId,});

  Common.fromJson(dynamic json) {
    appId = json['app_id'];
  }
  String? appId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_id'] = appId;
    return map;
  }

}