import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/view/diarycard.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/page/editdiarypage.dart';
import 'package:liba_note/utils/mulselectevent.dart';
import 'package:flutter/services.dart';
import 'dart:io';


class diarylistpage extends StatefulWidget {
  sqlhelper _sqlhlper;
  int BookId;

  diarylistpage(this._sqlhlper, this.BookId);

  State<StatefulWidget> createState() {
    return new _diarylistState();
  }
}

class _diarylistState extends State<diarylistpage> {
  int _countdiary = -1;
  Color _defaultcolor = Color.fromRGBO(74, 169, 170, 1);
  List<Widget> _listcard = new List();
  bool _LongPressStatu = false;

  @override
  initState() {
    super.initState();
    _getDiaryList();
  }

  _longclik() {
    eventBus.fire(true);
    setState(() {
      this._LongPressStatu = true;
    });
  }

  //获取日记列表
  _getDiaryList() async {
    _listcard.clear();
    List<Widget> temlistcard = new List();
    List<Map> res = await widget._sqlhlper.getDiary(widget.BookId);
    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        diary temdiary = new diary(h["title"], h["context"], h["bookid"],
            DateTime.parse(h["createtime"]), DateTime.parse(h["edittime"]));
        diarycard temdiarycard =
            new diarycard(temdiary, _defaultcolor, () => _longclik());
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
          builder: (context) => new editdiarypage("touyici", "dierci",
              widget._sqlhlper, _defaultcolor, widget.BookId),
        )).then((data) {
      _refresh();
    });
  }

  _getbody(int countdiary) {
    if (countdiary >= 0) {
      return
          // color: Colors.red,
          Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "$countdiary 条记录",
              style: TextStyle(
                  color: Color.fromRGBO(74, 169, 170, 1), fontSize: 10),
            ),
          ),
          Expanded(
              flex: 1,
              child: new RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemCount: _listcard.length,
                  itemBuilder: (context, i) {
                    return _listcard[i];
                  },
                ),
              ))
        ],
      );
    } else {
      return new Padding(
        padding: EdgeInsets.all(200),
        child: CupertinoActivityIndicator(),
      );
    }
  }

  _getappbar(bool longpressstatu) {
    if (longpressstatu == false) {
      return PreferredSize(
          child: new AppBar(
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
          preferredSize: Size.fromHeight(36));
    } else {
      return PreferredSize(
          child: new AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.ac_unit,
                  color: Color.fromRGBO(74, 169, 170, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(36));
    }
  }

  Future<bool> _back()
  {
    setState(() {
      _LongPressStatu = false;
    });
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _getappbar(_LongPressStatu),
          body: _getbody(_countdiary),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(74, 169, 170, 1),
            child: Icon(Icons.add),
            onPressed: _addDiaryPage,
          ),
        ),
        onWillPop: _back
    );
  }
}
