import 'dart:async';
import 'dart:io';

import 'package:feelings/About/About.dart';
import 'package:feelings/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:feelings/Settings/SettingsPage.dart';

import 'static.dart';

class ScreenShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShotPage>
    with TickerProviderStateMixin {
  List<Color> _colors = [genRandomColor(), genRandomColor()];
  Alignment _start = Alignment.topLeft;
  Alignment _end = Alignment.bottomRight;

  //Animation
  AnimationController _animationController;
  Animation _animation;
  bool _feeling = false;
  Timer timer;
  bool loading = false;

  //screenshot
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    Future<bool> _ifInitApp() async {
      SharedPreferences _shared = await SharedPreferences.getInstance();
      return _shared.getBool('isInitApp' ?? true);
    }

    _ifInitApp().then((onValue) {
      if ((onValue ?? true)) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SplashPage()));
        });
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: -1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Transform.translate(
        offset: Offset(0, -_animation.value * 80),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _colors = [
                    genRandomColor(),
                    genRandomColor(),
                  ];
                });
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FlareActor(
                  'Animation/random.flr',
                  animation: 'random',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
              heroTag: 'floatOne',
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _colors = [
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                    genRandomColor(),
                  ];
                });
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FlareActor(
                  'Animation/rainbow.flr',
                  animation: 'rainbow',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
              heroTag: 'floatThree',
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: 'floatTwo',
              onPressed: loading
                  ? null
                  : () {
                      setState(() {
                        loading = true;
                      });
                      print(MediaQuery.of(context).devicePixelRatio * 4);
                      screenshotController
                          .capture(
                        pixelRatio: MediaQuery.of(context).devicePixelRatio * 2,
                      )
                          .then((file) {
                        save() async {
                          Directory rootDir =
                              await getExternalStorageDirectory();
                          Directory temp = Directory(
                              rootDir.parent.parent.parent.parent.path);
                          await Directory('${temp.path}/feelings').create();
                          await file.copy(
                              '${temp.path}/feelings/${DateTime.now()}.png');
                        }

                        save();
                      }).then((_) {
                        setState(() {
                          loading = false;
                        });
                      });
                    },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: loading
                    ? CircularProgressIndicator()
                    : FlareActor(
                        'Animation/download.flr',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: 'download',
                      ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (!_feeling) {
                  timer = Timer.periodic(Duration(milliseconds: 3000), (_) {
                    setState(() {
                      _colors = [genRandomColor(), genRandomColor()];
                      _start = Alignment(
                          genRandomOneOrNegative(), genRandomOneOrNegative());
                      _end = Alignment(
                          genRandomOneOrNegative(), genRandomOneOrNegative());
                    });
                  });
                } else {
                  timer.cancel();
                }
                _animationController.fling(velocity: _feeling ? -1.0 : 1.0);
                _feeling = !_feeling;
              },
              child: Screenshot(
                controller: screenshotController,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _colors,
                      begin: _start,
                      end: _end,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Transform.translate(
                offset: Offset(0, _animation.value * 80),
                child: Container(
                  height: 100,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text('Feelings壁纸'),
                    actions: <Widget>[
                      MaterialButton(
                        child: Container(
                          child: FlareActor(
                            'Animation/typer.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'type',
                          ),
                          width: 35,
                        ),
                        minWidth: 10,
                        onPressed: () {
                          showMIUIDialog(
                            context: context,
                            dyOffset: 0.5,
                            content: GridView.count(
                              physics: MIUIScrollPhysics(),
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              children: <Widget>[
                                _genCard(Alignment.centerLeft,
                                    Alignment.centerRight),
                                _genCard(Alignment.topCenter,
                                    Alignment.bottomCenter),
                                _genCard(
                                    Alignment.topLeft, Alignment.bottomRight),
                                _genCard(
                                    Alignment.topRight, Alignment.bottomLeft),
                              ],
                            ),
                            label: 'dialog',
                          );
                        },
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              child: Text('关于'),
                              value: 1,
                            ),
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AboutPage(),
                                ),
                              );
                              break;
                            case 2:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SettingsPage(),
                                ),
                              );
                              break;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genCard(Alignment start, Alignment end) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: IconButton(
          icon: Icon(null),
          onPressed: () {
            setState(() {
              _start = start;
              _end = end;
            });
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: _colors,
            begin: start,
            end: end,
          ),
        ),
      ),
    );
  }
}
