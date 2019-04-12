import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/view/diarycard.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/page/editdiarypage.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class diarylistpage extends StatefulWidget {
  sqlhelper _sqlhlper;
  int BookId;
  diarylistpage(this._sqlhlper,this.BookId);

  State<StatefulWidget> createState() {
    return new _diarylistState();
  }
}

class _diarylistState extends State<diarylistpage> {
  int _countdiary = -1;
  Color _defaultcolor = Color.fromRGBO(74, 169, 170, 1);
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
    List<Map> res = await widget._sqlhlper.getDiary(widget.BookId);
    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        diary temdiary = new diary(h["title"], h["context"],h["bookid"],
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
      _countdiary = -1;
    });
    _getDiaryList();
    return;
  }

  _addDiaryPage() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new editdiarypage(
              "touyici", "dierci", widget._sqlhlper, _defaultcolor,widget.BookId),
        ));
  }

  _getbody() {
    if (_countdiary >= 0) {
      _listcard.insert(
          0,
          Container(
              //color: Colors.blueGrey,
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$_countdiary 条记录",
                style: TextStyle(
                    color: Color.fromRGBO(74, 169, 170, 1), fontSize: 10),
              ),
            ],
          )));
      return new ListView(
        children: _listcard,
      );
    }  else {
      return new Padding(
        padding: EdgeInsets.all(200),
        child: CupertinoActivityIndicator(),
      );
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(74, 169, 170, 1),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        // color: Colors.red,
        child: _getbody(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(74, 169, 170, 1),
        child: Icon(Icons.add),
        onPressed: _addDiaryPage,
      ),
    );
  }
}
