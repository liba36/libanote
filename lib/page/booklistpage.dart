import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/page/editbookpage.dart';
import 'package:liba_note/page/diarylistpage.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:liba_note/view/bookcard.dart';
import 'package:liba_note/model/book.dart';


class booklistpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _booklistState();
  }
}

class _booklistState extends State<booklistpage> {
  sqlhelper _SqlUtils = new sqlhelper();
  Color _ColorDeful = Color.fromRGBO(74, 169, 170, 1);
  String _title = "d";
  int _CountBook = -1;
  List<Widget> _BookList = new List();


  @override
  initState() {
    super.initState();
    _getbooklist();
  }

  _getbooklist() async {
    _BookList.clear();
    List<bookcard> temlistcard = new List();
    List<Map> res = await _SqlUtils.getBook();
    if (res.length > 0) {
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        book _BookTemp = new book(
          h["title"],
          h["type"],
          h["description"],
          h["image"],
          DateTime.parse(h["createtime"]),
          DateTime.parse(h["edittime"]),
        );
        _BookTemp.id = h["id"];
        bookcard _BookcardTemp = new bookcard(_SqlUtils, _BookTemp);
        temlistcard.add(_BookcardTemp);
      }
    }
    setState(() {
      _BookList.addAll(temlistcard);
      _CountBook = _BookList.length;
    });
    temlistcard.clear();
  }


  _getbody(){
    if (_CountBook >= 0) {
     return
       Container(
           padding: EdgeInsets.only(left: 10, right: 10, top: 10),
           child:Column(
             children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 6,top: 6),
                child:   Text("$_CountBook 个本子",style: TextStyle(
                    color: Color.fromRGBO(74, 169, 170, 1), fontSize: 12)),
              ),
               Expanded(
                 flex: 1,
                 child:   RefreshIndicator(
                   onRefresh: _refresh,
                   child:GridView.count(
                     //shrinkWrap:true,
                     crossAxisCount: 4,
                     //滚动方向
                     scrollDirection: Axis.vertical,
                     // 左右间隔
                     // crossAxisSpacing: 10.0,
                     // 上下间隔
                     mainAxisSpacing: 5.0,
                     //宽高比
                     childAspectRatio: 10 / 16,
                     children: _BookList,
                   ),
                 ),
               ),

             ],
           )

       );
    }  else {
      return new Padding(
        padding: EdgeInsets.all(200),
        child: CupertinoActivityIndicator(),
      );
    }
  }


  _bakshow() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('libanote will be stopped..'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  _addnewbook() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new editbookpage(0, _SqlUtils, _ColorDeful,null),
        )).then((data){
          _refresh();
    });
  }

  Future<Null> _refresh() async {
    setState(() {
      _CountBook = -1;
    });
   _getbooklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: new AppBar(
            backgroundColor: Colors.white,
            title: Icon(
              Icons.four_k,
              color:_ColorDeful,
            ),
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(36)),
      body: _getbody(),

      floatingActionButton: FloatingActionButton(
        onPressed: _addnewbook,
        backgroundColor: _ColorDeful,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, //底部工具栏的颜色。
        //设置底部栏的形状
        shape: CircularNotchedRectangle(),
        elevation: 36,
        child: Row(
          //里边可以放置大部分Widget，让我们随心所欲的设计底栏
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.view_carousel,
                color: _ColorDeful,
              ),
              //color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.settings, color: _ColorDeful),
              //color: _ColorDeful,
            ),
          ],
        ),
      ),
    );
  }
}

