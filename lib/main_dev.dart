import 'package:what_where_when_master/application/app.dart';
import 'package:what_where_when_master/application/config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppConfig(
    child: WwwMasterApp(),
    isDemo: true,
  ));
}
