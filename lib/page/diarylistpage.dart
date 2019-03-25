import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils//sqlhelper.dart';
import 'package:liba_note/view/diarycard.dart';
import 'package:liba_note/model//diary.dart';

class diarylistpage extends StatefulWidget {
  sqlhelper _sqlhlper;
  diarylistpage(this._sqlhlper);
  State<StatefulWidget> createState() {
    return new _diarylistState();
  }
}

class _diarylistState extends State<diarylistpage> {
  int _countdiary = -1;
  List<Widget> _listcard = new List();
  @override
  initState() {
    super.initState();
    _getDiaryList();
  }

  //获取日记列表
  _getDiaryList() async {
    _listcard.clear();
    List<diarycard> temlistcard = new List();
    List<Map> res = await widget._sqlhlper.getDiaryNote();
    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        diary temdiary = new diary(h["title"], h["context"],
            DateTime.parse(h["createtime"]), DateTime.parse(h["edittime"]));
        diarycard temdiarycard = new diarycard(temdiary);
        temlistcard.add(temdiarycard);
      }
    }    
    setState(() {
      _listcard.addAll(temlistcard);
      _countdiary = res.length; 
    });
    temlistcard.clear();
  }

  Future<Null> _refresh() async {
    setState(() {
     _countdiary = -2; 
    });
   _getDiaryList();   
    return;
  }

  _getbody() {
    if (_countdiary >= 0) {
      _listcard.insert(0, Card(
        color: Colors.blueGrey,
        child: Text("$_countdiary 条记录"),
      ));
      return new ListView(
        children: _listcard,
      );
    }else if(_countdiary == -2)
    {
      return new Container(
        //child: Text("正在刷新...")
      );
    } 
    else {
      return new Padding(
        padding: EdgeInsets.all(200),
        child: CupertinoActivityIndicator(),
      );
    }
  }

  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: _refresh,
      // color: Colors.red,
      child: _getbody(),
    );
  }
}
