import 'package:flutter/material.dart';
import 'package:feelings/model/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _numberCheck = true;
    TextEditingController _rateController=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ScopedModelDescendant<AppModel>(
              builder: (context, child, model) {
                return Card(
                  child: ListTile(
                    title: Text('壁纸输出比率'),
                    trailing: PopupMenuButton(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            model.wallPaperSize.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        elevation: 5,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            child: Text('0.7'),
                            value: 1,
                          ),
                          PopupMenuItem<int>(
                            child: Text('0.8'),
                            value: 2,
                          ),
                          PopupMenuItem<int>(
                            child: Text('0.9'),
                            value: 3,
                          ),
                          PopupMenuItem<int>(
                            child: Text('1.0'),
                            value: 4,
                          ),
                          PopupMenuItem<int>(
                            child: Text('1.1'),
                            value: 5,
                          ),
                          PopupMenuItem<int>(
                            child: Text('1.2'),
                            value: 6,
                          ),
                          PopupMenuItem<int>(
                            child: Text('1.3'),
                            value: 7,
                          ),
                          PopupMenuItem<int>(
                            child: Text('1.4'),
                            value: 8,
                          ),
                        ];
                      },
                      onSelected: (item) {
                        model.setWallPaperSize(0.6 + item * 0.1);
                      },
                    ),
                  ),
                );
              },
            ),
            ScopedModelDescendant<AppModel>(builder: (context, child, model) {
              return ListTile(
                title: TextField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    helperText: '请输入数字',
                    labelText: '自定义壁纸输出比率',
                  ),
                ),
                trailing: RaisedButton(
                  child: Text('修改'),
                  color: Colors.blue,
                  onPressed: () {
                    double temp=1;
                    bool mark=true;
                    try{
                      temp=double.parse(_rateController.text);
                    }catch (e){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('只能为数字'),
                        ),

                      );
                      mark=false;
                    }
                    if(temp<0){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('数字不能小于0'),
                        ),
                      );
                    }else if(temp >3){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('数字过大'),
                        ),
                      );
                    }else {
                      model.setWallPaperSize(temp);
                      if(mark){
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('修改成功'),
                          ),
                        );
                      }
                    }
                  },
                ),
              );
            },

            ),
          ],
        ),
      ),
    );
  }
}
