import 'package:feelings/About/StaticAbout.dart';
import 'package:flare_flutter/flare_actor.dart';
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

  List<List<String>> _projectList = [
    ['Flutter', 'https://github.com/flutter/flutter', 'Google'],
    ['AOSP', 'https://source.android.com/', 'Google'],
    ['Dart', 'https://dart.dev/', 'Google'],
    ['audioplayers', 'https://pub.dev/packages/audioplayers', 'Luan Nico'],
    ['url_launcher', 'https://pub.dev/packages/url_launcher', 'Flutter Team'],
    ['screenshot', 'https://pub.dev/packages/screenshot', 'Sachin Ganesh'],
    [
      'image_gallery_saver',
      'https://pub.dev/packages/image_gallery_saver',
      'quicey'
    ],
    [
      'permission_handler',
      'https://pub.dev/packages/permission_handler',
      'Baseflow\nlong1eu\nSebastian Roth'
    ],
    [
      'scoped_model',
      'https://pub.dev/packages/scoped_model',
      'Andrew Wilson\nBrian Ega'
    ],
    [
      'shared_preferences',
      'https://pub.dev/packages/shared_preferences',
      'Flutter Team'
    ],
    [
      'flare_flutter',
      'https://pub.dev/packages/flare_flutter',
      '2Dimensions Team'
    ],
  ];
  List<Widget> _projectsCards = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (List<String> item in _projectList) {
      OpenSourceProjects _openSourceProjects =
          OpenSourceProjects(item[0], item[1], item[2]);
      _projectsCards.add(_openSourceProjects.genListTile());
    }
  }

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
                  leading: Hero(
                    tag: 'action',
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
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
                    background: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'mid',
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_colorA, _colorB],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Hero(
                              tag: 'title2',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  '关于',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _projectsCards,
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
                      ListTile(
                        leading: Icon(Icons.person_pin),
                        title: Text(
                          '感谢下列动画作者',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://www.2dimensions.com/a/pollux/files/flare/devquest-joy-icon/preview'),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: FlareActor(
                                'Animation/smile.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: 'Appear',
                              ),
                            ),
                            trailing: Text('Guido Rosso'),
                            title: Text('DevQuest Joy Icon\nCC BY 4.0'),
                            subtitle: Text(
                                'https://www.2dimensions.com/a/pollux/files/flare/devquest-joy-icon/preview'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://www.2dimensions.com/a/daniil91/files/flare/animated-orb/preview'),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: FlareActor(
                                'Animation/load.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: 'Aura',
                              ),
                            ),
                            trailing: Text('Daniil Lisnyak '),
                            title: Text('Animated orb\nCC BY 4.0'),
                            subtitle: Text(
                                'https://www.2dimensions.com/a/daniil91/files/flare/animated-orb/preview'),
                          ),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://www.2dimensions.com/a/pollux/files/flare/success-check/preview'),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: FlareActor(
                                'Animation/success.flr',
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: 'success',
                              ),
                            ),
                            trailing: Text('Guido Rosso'),
                            title: Text('Success Check\nCC BY 4.0'),
                            subtitle: Text(
                                'https://www.2dimensions.com/a/pollux/files/flare/success-check/preview'),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.copyright),
                        title: Text(
                          '动画共享协议',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () => launch(
                              'https://creativecommons.org/licenses/by/4.0/'),
                          child: ListTile(
                            title: Text(
                                'Attribution 4.0 International (CC BY 4.0)'),
                            subtitle: Text(
                                'https://creativecommons.org/licenses/by/4.0/'),
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
