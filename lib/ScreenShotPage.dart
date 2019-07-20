import 'package:feelings/About/About.dart';
import 'package:feelings/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:feelings/static.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:feelings/model/AppModel.dart';
import 'package:feelings/Settings/SettingsPage.dart';
import 'dart:ui' as ui;

class ScreenShotPage extends StatefulWidget {
  ScreenShotPage({
    Key key,
    this.alignmentBegin,
    this.alignmentEnd,
    this.rainbow,
  }) : super(key: key);
  final Alignment alignmentBegin;
  final Alignment alignmentEnd;
  final bool rainbow;
  @override
  State<StatefulWidget> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShotPage> {
  File _imageFile;
  Color colorA = genRandomColor();
  Color colorB = genRandomColor();
  List<Color> _colors = [
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
    genRandomColor(),
  ];
  Color _backButtonColor = Colors.transparent;

  /// *
  /// EAST EGG!
  /// **/
  int _wallpaperButtonState = 0;

  _go2NextPage(Alignment alignmentA, Alignment alignmentB, bool rainbowState) {
    Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 350), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: ScreenShotPage(
              alignmentBegin: alignmentA,
              alignmentEnd: alignmentB,
              rainbow: rainbowState,
            ),
          );
        }),
      );
    });
  }

  List<Widget> _gradientList = [];

  @override
  void initState() {
    // TODO: implement initState
    /**
     * 获取应用第一次使用状态并显示Splash
     * */
    super.initState();

    AppModel appModel = ScopedModel.of<AppModel>(context);
    Widget _genListTile(
      Alignment alignmentOne,
      Alignment alignmentTwo,
      String text,
      int nowAlign,
    ) {
      bool selectButton = false;
      if (nowAlign == appModel.nowAlignment) selectButton = true;
      return FlatButton(
        color: selectButton ? Colors.blue : Colors.blueGrey,
        onPressed: () {
          _go2NextPage(
            alignmentOne,
            alignmentTwo,
            appModel.rainbowMode,
          );
          appModel.setAlignmentEnd(alignmentTwo);
          appModel.setAlignmentStart(alignmentOne);
          appModel.setNowAlignment(nowAlign);
        },
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: selectButton ? Colors.black : Colors.white,
            ),
          ),
          trailing: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: alignmentOne,
                end: alignmentTwo,
                colors: [
                  colorA,
                  colorB,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      );
    }

    _gradientList = [
      _genListTile(
        Alignment.topLeft,
        Alignment.bottomRight,
        '左上-右下',
        1,
      ),
      _genListTile(
        Alignment.topCenter,
        Alignment.bottomCenter,
        '上-下',
        2,
      ),
      _genListTile(
        Alignment.centerLeft,
        Alignment.centerRight,
        '左-右',
        3,
      ),
      _genListTile(
        Alignment.bottomLeft,
        Alignment.topRight,
        '左下-右上',
        4,
      ),
    ];

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
  }

  GlobalKey _globalKey = new GlobalKey();
  Future<Uint8List> _capturePng(double size) async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(
        pixelRatio: MediaQuery.of(context).devicePixelRatio*size);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: Container(
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
//                ScopedModelDescendant<AppModel>(
//                  builder: (context, child, model) {
//                    return FloatingActionButton(
//                      backgroundColor: colorB,
//                      onPressed: () {
//                        Navigator.pushReplacement(
//                          context,
//                          PageRouteBuilder(pageBuilder: (BuildContext context,
//                              Animation animation,
//                              Animation secondaryAnimation) {
//                            return FadeTransition(
//                              opacity: animation,
//                              child: ScreenShotPage(
//                                alignmentBegin: Alignment.centerLeft,
//                                alignmentEnd: Alignment.bottomCenter,
//                                rainbow: false,
//                              ),
//                            );
//                          }),
//                        );
//                      },
//                      child: Icon(Icons.developer_board),
//                      heroTag: 'floatTest',
//                    );
//                  },
//                ),
//                SizedBox(
//                  width: 20,
//                ),
                ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) {
                    return FloatingActionButton(
                      backgroundColor: colorB,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(pageBuilder: (BuildContext context,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScreenShotPage(
                                alignmentBegin: model.alignmentStart,
                                alignmentEnd: model.alignmentEnd,
                                rainbow: false,
                              ),
                            );
                          }),
                        );
                        model.setRainbowMode(false);
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
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) {
                    return FloatingActionButton(
                      backgroundColor: colorB,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(pageBuilder: (BuildContext context,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScreenShotPage(
                                alignmentBegin: model.alignmentStart,
                                alignmentEnd: model.alignmentEnd,
                                rainbow: true,
                              ),
                            );
                          }),
                        );
                        model.setRainbowMode(true);
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
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                ScopedModelDescendant<AppModel>(builder: ( context,  child,  model) {
                  return Builder(
                    builder: (BuildContext context) {
                      return FloatingActionButton(
                        heroTag: 'floatTwo',
                        backgroundColor: colorA,
                        onPressed: () {
                          _capturePng(model.wallPaperSize).then((image) {
                            ImageGallerySaver.save(image).then(
                                  (_) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: FlareActor(
                                            'Animation/smile.flr',
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain,
                                            animation: 'Appear',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          '已保存',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FlareActor(
                            'Animation/download.flr',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: 'download',
                          ),
                        ),
                      );
                    },
                  );
                },),
              ],
            ),
          ),
          body: Center(
            child: Stack(
              children: <Widget>[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    height: 1200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: widget.alignmentBegin,
                        end: widget.alignmentEnd,
                        colors: widget.rainbow
                            ? _colors
                            : [
                                colorA,
                                colorB,
                              ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Offstage(
                      offstage: !(_wallpaperButtonState == 3),
                      child: Hero(
                        tag: 'action1',
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: _backButtonColor,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Hero(
                          tag: 'mid',
                          child: SizedBox(
                            width: 1,
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
                        Hero(
                          tag: 'title2',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              '壁纸',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: _gradientList,
                                  ),
                                );
                              },
                            );
                          }),
                      Hero(
                        tag: 'action',
                        child: Material(
                          color: Colors.transparent,
                          child: PopupMenuButton(
                            child: Container(
                              child: FlareActor(
                                'Animation/menu.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: 'menuAni',
                              ),
                              width: 35,
                            ),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<int>(
                                  child: Text('渐变壁纸'),
                                  value: 1,
                                ),
                                PopupMenuItem<int>(
                                  child: Text('设置'),
                                  value: 2,
                                ),
                                PopupMenuItem<int>(
                                  child: Text('关于'),
                                  value: 0,
                                ),
                              ];
                            },
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AboutPage()));
                                  break;
                                case 1:
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              colorA,
                                              colorB,
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$_wallpaperButtonState:我只是个壁纸😂',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xaaffffff),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    _wallpaperButtonState++;
                                  });
                                  if (_wallpaperButtonState == 3) {
                                    setState(() {
                                      _backButtonColor = Colors.white;
                                    });
                                  }
                                  break;
                                case 2:
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SettingsPage()));
                                  break;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          return SystemNavigator.pop();
        });
  }
}
