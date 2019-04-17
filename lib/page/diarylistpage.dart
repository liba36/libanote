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
  bool _CheckBoxDisplay = false;

  @override
  initState() {
    super.initState();
    _getDiaryList();
  }

  _longclik() {
    eventBus.fire(new muldiaryselect(true));
    setState(() {
      this._CheckBoxDisplay = true;
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
    if(_CheckBoxDisplay == true) {
      setState(() {
        _CheckBoxDisplay = false;
      });
      eventBus.fire(new muldiaryselect(false));
    }
    else
      {
       Navigator.pop(context);
      }
  }

  _getFloatButtopn(bool statu)
  {
    if(statu == false)
      {
        return  FloatingActionButton(
          backgroundColor: Color.fromRGBO(74, 169, 170, 1),
          child: Icon(Icons.add),
          onPressed: _addDiaryPage,
        );
      }
    else
      {
        return null;
      }
  }
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _getappbar(_CheckBoxDisplay),
          body: _getbody(_countdiary),
          floatingActionButton:_getFloatButtopn(_CheckBoxDisplay),
        ),
        onWillPop: _back
    );
  }
}
