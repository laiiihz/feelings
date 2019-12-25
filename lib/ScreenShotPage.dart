import 'package:feelings/About/About.dart';
import 'package:feelings/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:feelings/static.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:feelings/Settings/SettingsPage.dart';

class ScreenShotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShotPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FlareActor(
                'Animation/download.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'download',
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
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

                        }),
                    PopupMenuButton(
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
                            child: Text('设置'),
                            value: 2,
                          ),
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
                                        AboutPage()));
                            break;
                          case 2:
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SettingsPage()));
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
