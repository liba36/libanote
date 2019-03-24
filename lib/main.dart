import 'package:flutter/material.dart';
import 'package:liba_note/page/notepage.dart';
import 'package:liba_note/page/planpage.dart';
import 'package:liba_note/utils//sqlhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:liba_note/model//diary.dart';
import 'package:liba_note/page/editdiarypage.dart';
import 'package:liba_note/page/diarylistpage.dart';


void main() => runApp(MyApp());

class Navitem {
  IconData icon;
  String title;

  Navitem(this.icon, this.title);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'LibaNote'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  sqlhelper _sqlhlper = new sqlhelper();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _blue = Color.fromRGBO(74, 169, 170, 1);
  Color _defulcolor;
  int _selectedDrawerIndex = 0;
  String title = "篱笆note";
  planpage _planpagm = new planpage("2019-01-01", "第一", "春雨哈哈哈");
  final _naviitemlist = [
    new Navitem(Icons.book, "日记"),
    new Navitem(Icons.account_balance_wallet, "计划"),
    new Navitem(Icons.assignment, "asds"),
    new Navitem(Icons.text_fields, "cai123dan"),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      //_defulcolor = Color.fromRGBO(76, 180, 231, 1);
      _defulcolor = Color.fromRGBO(74, 169, 170, 1);
    });
  }

  _getPage(int index) {
    switch (index) {
      case 0:
        return new diarylistpage(widget._sqlhlper);
      case 1:
        return new planpage("","","");
      case 4:
        _selectedDrawerIndex = 0;
        break;
      case 3:
        _selectedDrawerIndex = 0;
        break;
      case 2:
        return new editdiarypage(
            "touyici", "dierci", widget._sqlhlper, _defulcolor);
      default:
        _selectedDrawerIndex = 0;
        break;
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  _editdiarypage() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new editdiarypage(
              "touyici", "dierci", widget._sqlhlper, _defulcolor),
        ));   
  }

//点击返回时候的操作
  Future<bool> _onWillPop() {
    if (_selectedDrawerIndex == 0) {
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
    } else {
      setState(() {
        _selectedDrawerIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //添加底部tab
    var bottomOptions = <BottomNavigationBarItem>[];
    for (int i = 0; i < _naviitemlist.length; i++) {
      bottomOptions.add(
        new BottomNavigationBarItem(
            icon: new Icon(
              _naviitemlist[i].icon,
              color: Colors.white,
            ),
            title: new Text(_naviitemlist[i].title),
            backgroundColor: _blue),
      );
    }
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          backgroundColor: Color.fromRGBO(245, 245, 245, 5),
          appBar: AppBar(
            title: Text(title),
            backgroundColor: _defulcolor,
          ),
          body: _getPage(_selectedDrawerIndex),          
          floatingActionButton: FloatingActionButton(
            backgroundColor: _blue,
            onPressed: _editdiarypage,
            tooltip: 'Increment', //长按显示的文字
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: new BottomNavigationBar(
            items: bottomOptions,
            onTap: (index) => _onSelectItem(index),
            currentIndex: _selectedDrawerIndex,
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
