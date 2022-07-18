import 'dart:async';
import 'dart:convert' as convert;
import 'package:web_socket_channel/io.dart';

const appId = "83836aa0";
const apiSecret = "Y2M5OTI1MmZjY2NkNWYzZWY5OGJkMDRk";
const apiKey = "445f5702911ec04cfc9155e1350b2a53";
const String hostUrl = "wss://tts-api.xfyun.cn/v2/tts";

class SocketUtils {
  SocketUtils._();

  static SocketUtils instance = SocketUtils._();
  IOWebSocketChannel? _channel;
  Timer? _timer;

  void initSocket() {
    getAuthUrl(hostUrl, apiKey, apiSecret);

    _channel = IOWebSocketChannel.connect(Uri.parse("url"));
    Map<String, dynamic> params = Map<String, dynamic>();
    // params["userId"] = SpUtils().getUserInfo().appUserDetailsVO.drvId;
    // params["userName"] = SpUtils().getUserInfo().appUserDetailsVO.drvName;
    // params["token"] = SpUtils().getUserInfo().token;

    // 发送信息
    _channel?.sink.add(convert.jsonEncode(params));

    // 接收信息
    _channel?.stream.listen(this.onData, onError: onError, onDone: onDone);
    startCountdownTimer();
  }

  ///开启心跳
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 10);
    var callback = (timer) {
      if (_channel == null) {
        initSocket();
      } else {}
    };
    _timer = Timer.periodic(oneSec, callback);
  }

  onDone() {
    print("消息关闭");
    _channel?.sink.close();
    _channel = null;
  }

  onError(err) {
    print("消息错误$err");
    if (_channel != null) {
      _channel?.sink.close();
      _channel = null;
    }
  }

  onData(event) {
    print("result ==  $event");
  }

  void dispose() {
    if (_channel != null) {
      _channel?.sink.close();
      print("socket通道关闭");
      _channel = null;
    }
    _timer?.cancel();
    _timer = null;
  }

  /// 鉴权
  void getAuthUrl(String url1, String apiKey, String apiSecret) {





  }
}
