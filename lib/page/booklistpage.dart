import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/page/addbookpage.dart';
import 'package:liba_note/page/diarylistpage.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class booklistpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _booklistState();
  }
}

class _booklistState extends State<booklistpage> {
  //sqlhelper _sqlhelper = new sqlhelper();
  sqlhelper _sqlutils = new sqlhelper();
  Color _defaultcolor = Color.fromRGBO(74, 169, 170, 1);
  String _title = "d";
  List<Widget> test() {
    List<Widget> list = new List();
    for (int i = 0; i < 100; i++) {
      list.add(_getGridItem());
    }
    return list;
  }

  _showdi() {
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

  Widget _getGridItem() {
    return new GestureDetector(
        onTap: _editdiarypage,
        onLongPress: _showdi,
        child: Column(
          children: <Widget>[
            new Image.asset(
              'assets/images/diary-y.png',
              height: 92.13,
              width: 65.55,
              fit: BoxFit.fill,
            ),
            Text(_title),
          ],
        ));
  }

  _editdiarypage() {
    /*  Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) =>
              new editdiarypage("touyici", "dierci", _sqlhlper, _defulcolor),
        ));*/

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new diarylistpage(_sqlutils)));
  }

  _addnewbook() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new addbookpage(),
        ));

  }

  Future<Null> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(child: new AppBar(
        backgroundColor:_defaultcolor,
        elevation: 0,
      ),
          preferredSize: Size.fromHeight(20)),
       
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: GridView.count(
            crossAxisCount: 4,
            //滚动方向
            scrollDirection: Axis.vertical,
            // 左右间隔
         //  crossAxisSpacing: 10.0,
            // 上下间隔
            mainAxisSpacing: 10.0,
            //宽高比
            childAspectRatio: 9 / 13,
            children: test(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addnewbook,
        backgroundColor: _defaultcolor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: _defaultcolor, //底部工具栏的颜色。
        //设置底部栏的形状
        shape: CircularNotchedRectangle(),
        child: Row(
          //里边可以放置大部分Widget，让我们随心所欲的设计底栏
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.view_carousel,
                color: Colors.white,
              ),
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
