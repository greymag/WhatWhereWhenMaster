import 'package:WhatWhereWhenMaster/application/app.dart';
import 'package:WhatWhereWhenMaster/application/config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppConfig(
    child: WwwMasterApp(),
    isDemo: true,
  ));
}
