import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  Alignment _alignmentStart = Alignment.topLeft;
  Alignment _alignmentEnd = Alignment.bottomRight;
  Alignment get alignmentStart => _alignmentStart;
  Alignment get alignmentEnd => _alignmentEnd;
  void setAlignmentStart(Alignment alignment) {
    _alignmentStart = alignment;
    notifyListeners();
  }

  void setAlignmentEnd(Alignment alignment) {
    _alignmentEnd = alignment;
    notifyListeners();
  }

  int _a = 10;
  get a => _a;
  void setA() {
    _a = 10;
    notifyListeners();
  }
}
