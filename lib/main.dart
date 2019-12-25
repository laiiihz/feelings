import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:feelings/model/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ScreenShotPage.dart';
void main() {
  timeDilation=1.5;
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
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MaterialApp(
        title: 'Feelings',
        home: ScreenShotPage(),
      ),
    );
  }
}
