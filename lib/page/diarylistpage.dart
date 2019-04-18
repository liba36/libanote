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
  List<diarycard> _listcard = new List();
  bool _CheckBoxDisplay = false;
  List<int> _DiarySelect = new List();
  bool _RefreshStatu = false;

  @override
  initState() {
    super.initState();
    _getDiaryList();
    eventBus
        .on<muldiaryselect>()
        .listen((muldiaryselect onData) => _setCheckBoxDisplay(onData));
    eventBus
        .on<diaryslected>()
        .listen((diaryslected onData) => _setDiarySelect(onData));
  }

  _setDiarySelect(diaryslected onData) {
    if (onData.statu == true) {
      setState(() {
        _DiarySelect.add(onData.id);
      });
    } else {
      setState(() {
        _DiarySelect.remove(onData.id);
      });
    }
  }

  _setCheckBoxDisplay(muldiaryselect onData) {
    _DiarySelect.clear();
    setState(() {
      this._CheckBoxDisplay = onData.MulSelectEndable;
    });
    for (int i = 0; i < _listcard.length; i++) {
      _listcard[i].CheckBoxDisplay = onData.MulSelectEndable;
      if (onData.MulSelectEndable == false) {
        _listcard[i].Checked = false;
      }
    }
  }

  //获取日记列表
  _getDiaryList() async {
    _listcard.clear();
    List<diarycard> temlistcard = new List();
    List<Map> res = await widget._sqlhlper.getDiary(widget.BookId);
    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        diary temdiary = new diary(
            h["id"],
            h["title"],
            h["context"],
            h["bookid"],
            DateTime.parse(h["createtime"]),
            DateTime.parse(h["edittime"]));
        diarycard temdiarycard =
            new diarycard(temdiary, _defaultcolor, _CheckBoxDisplay);
        temlistcard.add(temdiarycard);
      }
    }
    setState(() {
      _listcard.addAll(temlistcard);
      _countdiary = res.length;
      _RefreshStatu = true;
    });
    temlistcard.clear();
  }

  Future<Null> _refresh() async {
    if (_CheckBoxDisplay == false) {
      setState(() {
        _countdiary = 0;
        _RefreshStatu = false;
      });
      _getDiaryList();
    }
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

  _getListText(statu) {
    if (statu == false) {
      return Text(
        "$_countdiary 条记录",
        style: TextStyle(color: Color.fromRGBO(74, 169, 170, 1), fontSize: 10),
      );
    } else {
      return Text(
        "已经选中 " + _DiarySelect.length.toString() + " 条记录",
        style: TextStyle(color: Color.fromRGBO(74, 169, 170, 1), fontSize: 10),
      );
    }
  }

  _getListBuild(statu) {
    if (_CheckBoxDisplay == false) {
      return new RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _listcard.length,
          itemBuilder: (context, i) {
            return _listcard[i];
          },
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _listcard.length,
        itemBuilder: (context, i) {
          return _listcard[i];
        },
      );
    }
  }

  _getbody(bool statu) {
    if (statu == true) {
      return
          // color: Colors.red,
          Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: _getListText(_CheckBoxDisplay),
          ),
          Expanded(
            flex: 1,
            child: _getListBuild(_CheckBoxDisplay),
          )
        ],
      );
    } else {
      return new Padding(
        padding: EdgeInsets.all(200),
        child: CupertinoActivityIndicator(),
      );
    }
  }

  _delete()
  {
    for(int i =0;i<_DiarySelect.length;i++)
      {
        widget._sqlhlper.deleteDiary(_DiarySelect[i]);
      }
    setState(() {
      _CheckBoxDisplay = false;
      _DiarySelect.clear();
    });
    _refresh();
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
            leading: RawMaterialButton(
              onPressed: _back,
              child: Text(
                "取消",
                style: TextStyle(fontSize: 15, color: _defaultcolor),
              ),
            ),
            elevation: 0,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.delete,color: _defaultcolor,), onPressed: _delete)
            ],
          ),
          preferredSize: Size.fromHeight(36));
    }
  }

  Future<bool> _back() {
    if (_CheckBoxDisplay == true) {
      eventBus.fire(new muldiaryselect(false));
    } else {
      Navigator.pop(context);
    }
  }

  _getFloatButtopn(bool statu) {
    if (statu == false) {
      return FloatingActionButton(
        backgroundColor: Color.fromRGBO(74, 169, 170, 1),
        child: Icon(Icons.add),
        onPressed: _addDiaryPage,
      );
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _getappbar(_CheckBoxDisplay),
          body: _getbody(_RefreshStatu),
          floatingActionButton: _getFloatButtopn(_CheckBoxDisplay),
        ),
        onWillPop: _back);
  }
}
