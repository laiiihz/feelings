import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceProjects{
  String _name;
  String _web;
  String _author;
  OpenSourceProjects(String name,String web,String author){
    _name=name;
    _web=web;
    _author=author;
  }

  Widget genListTile(){
    return Card(
      child: FlatButton(
        onPressed: () => launch(_web),
        child: ListTile(
          title: Text(_name),
          subtitle: Text(_web),
          trailing: Text(_author),
        ),
      ),
    );
  }
}