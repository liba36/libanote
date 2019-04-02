import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils//sqlhelper.dart';
import 'package:liba_note/page/editdiarypage.dart';
import 'package:liba_note/page/addbookpage.dart';

class booklistpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _booklistState();
  }
}

class _booklistState extends State<booklistpage> {
  sqlhelper _sqlhlper = new sqlhelper();
  Color _defulcolor = Color.fromRGBO(74, 169, 170, 1);
  String _title = "defaut";

  List<Widget> test() {
    List<Widget> list = new List();
    for (int i = 0; i < 5; i++) {
      list.add(_getGridItem());
    }
    return list;
  }

  Widget _getGridItem() {
    return new GestureDetector(
        onLongPress: _editdiarypage,
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
  setState(() {
    _title="edit";
  });

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
      appBar: new AppBar(
        title: new Text("liba36"),
        backgroundColor: _defulcolor,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: GridView.count(
            crossAxisCount: 4,
            //滚动方向
            scrollDirection: Axis.vertical,
            // 左右间隔
            crossAxisSpacing: 10.0,
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
        backgroundColor: _defulcolor,
        child: Icon(Icons.add),
      ),
    );
  }
}
