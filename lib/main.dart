import 'package:flutter/material.dart';
import 'package:feelings/Home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
void main() {
  timeDilation=2.0;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feelings',
      home: HomePage(),
    );
  }
}
