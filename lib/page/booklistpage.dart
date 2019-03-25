import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils//sqlhelper.dart';
import 'package:liba_note/page/editdiarypage.dart';

class booklistpage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _booklistState();
  }
}

class _booklistState extends State<booklistpage> {
  sqlhelper _sqlhlper =  new sqlhelper();
  Color _defulcolor = Colors.amber;

  List<Widget> test() {
    return <Widget>[
      GestureDetector(
        onTap:_editdiarypage,
        child:Card(
          child: Text("nihao"),
        ),
      ),
      Card(
        child: Text("nihao"),
      ),
      Card(
        child: Text("nihao"),
      ),
    ];
  }

  Widget _getGridItem() {
    return new Column(
      children: <Widget>[
        Text("asdsda"),
        RaisedButton(
         // onPressed: _editdiarypage(),
        ),
      ],
    );
  }

  _editdiarypage() {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) =>
          new editdiarypage(
              "touyici", "dierci", _sqlhlper, _defulcolor),
        ));
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
             child: GridView.count(
                crossAxisCount: 3,
                children: test(),
              ),

          )



      );
    }
  }



