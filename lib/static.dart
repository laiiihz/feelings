import 'dart:math';

import 'package:flutter/material.dart';

Color genRandomColor(){
  int baseColor=0xff000000;
  int tempRandomNum=0xffffff-0x000000;
  int randomNum=baseColor+Random().nextInt(tempRandomNum);
  return Color(randomNum);
}