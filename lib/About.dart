import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:feelings/static.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  final _colorA = genRandomColor();
  final _colorB = genRandomColor();
  final _colorC = genRandomColor();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _colorB,
                    _colorC,
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0x88ffffff),
            ),
            CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: _colorB,
                  title: Hero(
                      tag: 'title',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          'Feelings',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      )),
                  centerTitle: true,
                  floating: true,
                  pinned: false,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_colorA, _colorB],
                        ),
                      ),
                      child: Center(
                        child: Hero(
                          tag: 'title2',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              '关于',
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: 200,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.apps),
                        title: Text(
                          '关于此项目',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                onPressed: () => launch(
                                    'https://github.com/laiiihz/feelings'),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/fgithub.png',
                                      height: 60,
                                    ),
                                    Center(
                                      child: RichText(
                                          text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Feelings',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purpleAccent,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          TextSpan(
                                            text: '\nOn',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: 'Github',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                onPressed: () {
                                  launch(
                                      'https://www.coolapk.com/apk/tech.laihz.feelings');
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/fcoolapk.png',
                                      height: 60,
                                    ),
                                    Center(
                                      child: RichText(
                                          text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Feelings',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purpleAccent,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          TextSpan(
                                            text: '\nOn',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: 'Coolapk',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff12b566),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(Icons.person_pin),
                        title: Text(
                          '关于作者',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                onPressed: () =>
                                    launch('https://github.com/laiiihz'),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/github.png',
                                      height: 40,
                                    ),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Laiiihz',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black,
                                                    fontSize: 20)),
                                            TextSpan(
                                              text: '\nGithub',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                onPressed: () =>
                                    launch('https://www.coolapk.com/u/748141'),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/coolapk.png',
                                      height: 40,
                                    ),
                                    Center(
                                      child: RichText(
                                        text: new TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Laihz',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black,
                                                    fontSize: 20)),
                                            new TextSpan(
                                              text: '\nCoolapk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(Icons.code),
                        title: Text(
                          '感谢下列开源项目',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                        subtitle: Text('排名不分先后'),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () =>
                              launch('https://github.com/flutter/flutter'),
                          child: ListTile(
                            title: Text('Flutter'),
                            subtitle:
                                Text('https://github.com/flutter/flutter'),
                            trailing: Text('Google'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () =>
                              launch('https://source.android.com/'),
                          child: ListTile(
                            title: Text('AOSP'),
                            subtitle: Text('https://source.android.com/'),
                            trailing: Text('Google'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch('https://dart.dev/'),
                          child: ListTile(
                            title: Text('Dart'),
                            subtitle: Text('https://dart.dev/'),
                            trailing: Text('Google'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () =>
                              launch('https://pub.dev/packages/audioplayers'),
                          child: ListTile(
                            title: Text('audioplayers'),
                            subtitle:
                                Text('https://pub.dev/packages/audioplayers'),
                            trailing: Text('Luan Nico'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () =>
                              launch('https://pub.dev/packages/url_launcher'),
                          child: ListTile(
                            title: Text('url_launcher'),
                            subtitle:
                                Text('https://pub.dev/packages/url_launcher'),
                            trailing: Text('Flutter Team'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () =>
                              launch('https://pub.dev/packages/screenshot'),
                          child: ListTile(
                            title: Text('screenshot'),
                            subtitle:
                                Text('https://pub.dev/packages/screenshot'),
                            trailing: Text('Sachin Ganesh'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://pub.dev/packages/image_gallery_saver'),
                          child: ListTile(
                            title: Text('image_gallery_saver'),
                            subtitle: Text(
                                'https://pub.dev/packages/image_gallery_saver'),
                            trailing: Text('quicey'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://pub.dev/packages/permission_handler'),
                          child: ListTile(
                            title: Text('permission_handler'),
                            subtitle: Text(
                                'https://pub.dev/packages/permission_handler'),
                            trailing: Text('Baseflow\nlong1eu\nSebastian Roth'),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.group_work),
                        title: Text(
                          '感谢下列无版权资源',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://www.youtube.com/audiolibrary/soundeffects?ar=3'),
                          child: ListTile(
                            leading: Icon(Icons.music_note),
                            title: Text('ThunderStorm'),
                            subtitle: Text(
                                'https://www.youtube.com/audiolibrary/soundeffects?ar=3'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '© 2019 laihz.tech',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
