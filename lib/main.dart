import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'models/yht_res.dart';

void main() {
 App.init();
}





























//
// class _MyHomePage extends StatefulWidget {
//   _MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<_MyHomePage> {
//   var yhtRes = YhtRes();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: Column(children: [
//         Container(
//           margin: EdgeInsets.only(top: 20),
//           child: ElevatedButton(
//             child: Text("扫码"),
//             onPressed: () {
//               // 扫描
//               scarn();
//             },
//           ),
//         ),
//         Container(
//             margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             child: Row(
//               children: [
//                 Text("姓名：", style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 Expanded(
//                     child: Text(
//                   yhtRes.message ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54),
//                 ))
//               ],
//             )),
//         Container(
//             margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             child: Row(
//               children: [
//                 Text("手机：", style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 Expanded(
//                     child: Text(
//                   yhtRes.message ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54),
//                 ))
//               ],
//             )),
//         Container(
//             margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             child: Row(
//               children: [
//                 Text("公司：", style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 Expanded(
//                     child: Text(
//                   yhtRes.message ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54),
//                 ))
//               ],
//             )),
//         Container(
//             margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             child: Row(
//               children: [
//                 Text("备注：", style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 Expanded(
//                     child: Text(
//                   yhtRes.message ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54),
//                 ))
//               ],
//             )),
//         Container(
//             margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             child: Row(
//               children: [
//                 Text("是否有晚宴：",
//                     style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 Expanded(
//                     child: Text(
//                   yhtRes.message ?? "",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54),
//                 ))
//               ],
//             )),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "签到状态：",
//               style: TextStyle(color: Colors.lightGreen),
//             ),
//             Text(
//               "已签到",
//               style: TextStyle(color: Colors.lightGreen),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               child: ElevatedButton(
//                 child: Text("补打签到码"),
//                 onPressed: () {},
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 10, right: 10, top: 20),
//               child: ElevatedButton(
//                 child: Text("分论坛签到"),
//                 onPressed: () {},
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               child: ElevatedButton(
//                 child: Text("继续扫码"),
//                 onPressed: () {},
//               ),
//             )
//           ],
//         ),
//         // ListView.builder(
//         //   itemCount: 20,
//         //   itemBuilder: (BuildContext context, int index) {
//         //     return Text("data");
//         //   },
//         // )
//       ]),
//     );
//   }
//
//   Future scarn() async {
//     String cameraScanResult = await scanner.scan(); //通过扫码获取二维码中的数据
//     getScan(cameraScanResult); //将获取到的参数通过HTTP请求发送到服务器
//     jsonDecode("source");
//   }
//
//   //get请求
//   void getScan(String scan) async {
//     var url =
//         "https://mapi.instrument.com.cn/yht/v1/user/sign?meetId=nfcrsp8urh9d8lc7&signCode=" +
//             scan;
//     var dio = Dio();
//     var response = await dio.get(url);
//     var data = response.data;
//     var yhtBean = YhtRes.fromJson(data);
//     setState(() {
//       if (scan != null) {
//         this.yhtRes = yhtBean;
//       }
//     });
//   }
// }
