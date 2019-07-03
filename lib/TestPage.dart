import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<TestPage> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0)
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.pink,
                          Colors.purple,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: FlareActor(
                            "Animation/logo.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "logoAni",
                          ),
                        ),
                        Text(
                          '欢迎使用Feelings',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xaaffffff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: MaterialButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xaaffffff),
                                  size: 40,
                                ),
                                onPressed: () {
                                  _pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                height: 100,
                                minWidth: 100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                else if (index == 1) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.pink,
                          Colors.purple,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: FlareActor(
                            'Animation/wallpaper.flr',
                            animation: 'wallpaper',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          '优美的随机壁纸',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xaaffffff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: MaterialButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xaaffffff),
                                  size: 40,
                                ),
                                onPressed: () {
                                  _pageController.animateToPage(2,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                height: 100,
                                minWidth: 100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (index == 2) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.pink,
                          Colors.purple,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: FlareActor(
                            'Animation/load.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'Aura',
                          ),
                        ),
                        Text(
                          '我们需要获取\n您的读写手机存储权限\n以保存您的图片',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xaaffffff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.cancel),
                                    Text(
                                      '拒绝',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              RaisedButton(
                                color: Color(0xaaffffff),
                                onPressed: () {
                                  _pageController.animateToPage(3,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.check_circle),
                                    Text(
                                      '同意并继续',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.pink,
                          Colors.purple,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: FlareActor(
                            'Animation/success.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'success',
                          ),
                        ),
                        Text(
                          '开始使用',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xaaffffff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Hero(
                          tag: 'title',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Feelings',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: MaterialButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xaaffffff),
                                  size: 40,
                                ),
                                onPressed: () {
                                  _check() async {
                                    Map<PermissionGroup, PermissionStatus>
                                        permissions = await PermissionHandler()
                                            .requestPermissions(
                                                [PermissionGroup.storage]);
                                  }

                                  _check();
                                  Navigator.of(context).pop();
                                  _setInitApp() async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setBool(
                                        'isInitApp', false);
                                  }

                                  _setInitApp();
                                },
                                height: 100,
                                minWidth: 100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemCount: 4,
            ),
          ),
        ),
        onWillPop: (){
          SystemNavigator.pop();
        });
  }
}
