import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:feelings/static.dart';
import 'package:feelings/About.dart';
import 'package:feelings/ScreenShotPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  Timer timer;

  AnimationController _animationController;
  Animation<Color> _animationColor;
  Animation<Color> _animationColor2;

  var _colorA = genRandomColor();
  var _colorB = genRandomColor();

  var _colorA2 = genRandomColor();
  var _colorB2 = genRandomColor();
  bool _stopped = true;

  AudioCache audioPlayer;
  AudioPlayer _audioAdvancedAudioPlayer;

  var _valueMusic = 0.0;
  var _durationMusicMillseondc = 0;
  var _durationNow = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioCache();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animationColor = ColorTween(
      begin: _colorA,
      end: _colorB,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationColor2 = ColorTween(
      begin: _colorA2,
      end: _colorB2,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    timer = Timer.periodic(Duration(seconds: 3), (time) {
      if (time.tick % 2 != 0) {
        print('go');
        if (!_stopped) {
          setState(() {
            _colorA = genRandomColor();
            _colorA2 = genRandomColor();
          });
        } else {
          setState(() {
            _colorA = _colorB;
            _colorA2 = _colorB2;
          });
        }
        _animationColor = ColorTween(
          begin: _colorA,
          end: _colorB,
        ).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

        _animationColor2 = ColorTween(
          begin: _colorA2,
          end: _colorB2,
        ).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
        _animationController.reverse();
      } else {
        print('back');
        if (!_stopped) {
          setState(() {
            _colorB = genRandomColor();
            _colorB2 = genRandomColor();
          });
        } else {
          _colorB = _colorA;
          _colorB2 = _colorA2;
        }

        _animationColor = ColorTween(
          begin: _colorA,
          end: _colorB,
        ).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
        _animationColor2 = ColorTween(
          begin: _colorA2,
          end: _colorB2,
        ).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            playLocal() async {
              print('启动');
              _audioAdvancedAudioPlayer =
                  await audioPlayer.play('Thunderstorm.mp3', volume: 1);
              _audioAdvancedAudioPlayer.onDurationChanged.listen((onData) {
                setState(() {
                  _durationMusicMillseondc = onData.inMilliseconds;
                });
              });
              _audioAdvancedAudioPlayer.onAudioPositionChanged.listen((onData) {
                setState(() {
                  _valueMusic =
                      onData.inMilliseconds / _durationMusicMillseondc;
                  _durationNow = onData.inMilliseconds;
                });
              });
            }

            stopLocal() {
              print('停止');
              _audioAdvancedAudioPlayer.pause();
            }

            if (_stopped) {
              playLocal();
            } else {
              stopLocal();
            }
            setState(() {
              _stopped = !_stopped;
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: _colorA,
          child: _stopped ? Icon(Icons.play_arrow) : Icon(Icons.stop),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.centerRight,
                child: AppBar(
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
                      SizedBox(
                        width: 20,
                      ),
                      Hero(
                        tag: 'title2',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            '主页',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<int>(
                            child: Text('渐变壁纸'),
                            value: 1,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ScreenShotPage(
                                        alignmentBegin: Alignment.topLeft,
                                        alignmentEnd: Alignment.bottomRight,
                                        rainbow: false,
                                      )),
                            );
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Slider(
                  value: _valueMusic,
                  onChanged: (value) {
                    setState(() {
                      _valueMusic = value;
                    });
                  },
                  onChangeEnd: (value) {
                    print(value);
                    seekMusic() async {
                      value = value * 100;
                      int valueInt = value.toInt();
                      double temp = valueInt * _durationMusicMillseondc / 100;
                      await _audioAdvancedAudioPlayer
                          .seek(Duration(milliseconds: temp.toInt()));
                      //await _audioAdvancedAudioPlayer.seek(Duration(milliseconds: ));
                    }

                    seekMusic();
                  },
                  activeColor: Colors.white,
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 40, top: 0, right: 0, bottom: 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(_durationNow)
                              .minute
                              .toString() +
                          ":" +
                          DateTime.fromMillisecondsSinceEpoch(_durationNow)
                              .second
                              .toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 0, top: 0, right: 40, bottom: 0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(
                                  _durationMusicMillseondc)
                              .minute
                              .toString() +
                          ":" +
                          DateTime.fromMillisecondsSinceEpoch(
                                  _durationMusicMillseondc)
                              .second
                              .toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_animationColor.value, _animationColor2.value],
            ),
          ),
        ),
      );
}
