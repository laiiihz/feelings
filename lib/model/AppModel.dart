import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  Alignment _alignmentStart = Alignment.topLeft;
  Alignment _alignmentEnd = Alignment.bottomRight;
  Alignment get alignmentStart => _alignmentStart;
  Alignment get alignmentEnd => _alignmentEnd;

  int _nowAlignmentNum=1;
  int get nowAlignment=>_nowAlignmentNum;
  void setAlignmentStart(Alignment alignment) {
    _alignmentStart = alignment;
    notifyListeners();
  }

  void setAlignmentEnd(Alignment alignment) {
    _alignmentEnd = alignment;
    notifyListeners();
  }

  void setNowAlignment(int nowAlign){
    _nowAlignmentNum=nowAlign;
    notifyListeners();
  }

  bool _rainbowMode=false;
  get rainbowMode=>_rainbowMode;
  setRainbowMode(bool rainbow){
    _rainbowMode=rainbow;
    notifyListeners();
  }

  double _wallPaperSize=1.0;
  double get wallPaperSize=>_wallPaperSize;
  setWallPaperSize(double rate){
    _wallPaperSize=rate;
    notifyListeners();
  }

}
