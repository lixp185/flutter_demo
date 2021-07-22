import 'package:flutter/material.dart';

class HomeBean {
  final String title;
  final String? path;
  final Widget? page;

  final int? type;

  HomeBean(this.title, this.path, this.page,{this.type});
}
