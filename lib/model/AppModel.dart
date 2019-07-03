import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class AppModel extends Model{
  bool _isInitApp=true;
  get isInitApp=>_isInitApp;
}