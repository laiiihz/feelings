import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:feelings/static.dart';

class ScreenShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShotPage> {
  ScreenshotController _screenshotController = ScreenshotController();
  File _imageFile;
  Color colorA = genRandomColor();
  Color colorB = genRandomColor();
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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              setState(() {
                colorA = genRandomColor();
                colorB = genRandomColor();
              });
            },
            child: Icon(Icons.refresh),
            heroTag: 'floatOne',
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            heroTag: 'floatTwo',
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
            label: Text('保存'),
            icon: Icon(Icons.save_alt),
          ),
        ],
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
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
                title: Hero(
                  tag: 'title',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Feelings',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
