import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:feelings/static.dart';

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
  ScreenshotController _screenshotController = ScreenshotController();
  File _imageFile;
  Color colorA = genRandomColor();
  Color colorB = genRandomColor();
  _go2NextPage(
    Alignment alignmentA,
    Alignment alignmentB,
  ) {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScreenShotPage(
            alignmentBegin: alignmentA,
            alignmentEnd: alignmentB,
            rainbow: false,
          ),
        );
      }),
    );
  }

  Widget _genListTile(
    Alignment alignmentOne,
    Alignment alignmentTwo,
    String text,
  ) {
    return FlatButton(
      onPressed: () {
        _go2NextPage(
          alignmentOne,
          alignmentTwo,
        );
      },
      child: ListTile(
        title: Text(text),
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

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _check() async {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
    }

    _check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: colorB,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScreenShotPage(
                        alignmentBegin: Alignment.topLeft,
                        alignmentEnd: Alignment.bottomRight,
                        rainbow: false,
                      ),
                    );
                  }),
                );
              },
              child: Icon(Icons.shuffle),
              heroTag: 'floatOne',
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              backgroundColor: colorB,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScreenShotPage(
                        alignmentBegin: Alignment.topLeft,
                        alignmentEnd: Alignment.bottomRight,
                        rainbow: true,
                      ),
                    );
                  }),
                );
              },
              child: Icon(Icons.grain),
              heroTag: 'floatThree',
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: 'floatTwo',
              backgroundColor: colorA,
              onPressed: () {
                _screenshotController.capture().then((file) {
                  setState(() {
                    _imageFile = file;
                  });
                  _saveImage() async {
                    Uint8List bytes = _imageFile.readAsBytesSync() as Uint8List;
                    final image = await ImageGallerySaver.save(bytes);
                  }

                  _saveImage();
                }).catchError((onError) {
                  print(onError);
                });
              },
              child: Icon(Icons.save_alt),
            ),
          ],
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Screenshot(
              controller: _screenshotController,
              child: Container(
                height: 1200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: widget.alignmentBegin,
                    end: widget.alignmentEnd,
                    colors: widget.rainbow
                        ? [
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                            genRandomColor(),
                          ]
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
                leading: Hero(
                  tag: 'action',
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                      tag: 'title',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          'Feelings',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'title2',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          '壁纸',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.panorama_wide_angle),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _genListTile(
                                    Alignment.topCenter,
                                    Alignment.bottomCenter,
                                    '上-下',
                                  ),
                                  _genListTile(
                                    Alignment.centerLeft,
                                    Alignment.centerRight,
                                    '左-右',
                                  ),
                                  _genListTile(
                                    Alignment.bottomLeft,
                                    Alignment.topRight,
                                    '左下-右上',
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
