import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';

class diaryviewpage extends StatefulWidget{
  Color ColorDeful;
  diary DiaryInstance;
  diaryviewpage(this.ColorDeful,this.DiaryInstance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _diaryviewState();
  }
}

class _diaryviewState extends State<diaryviewpage>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(widget.DiaryInstance.edittime.toString()),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: widget.ColorDeful,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 18,right: 18),
            alignment: Alignment.centerLeft,
            child: Text(widget.DiaryInstance.title,
              style: TextStyle(
                fontSize: 25,

              ),
              softWrap: true,
              maxLines: null,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 17,right: 17,top: 20),
            child: Text(widget.DiaryInstance.context,
            style: TextStyle(
              fontSize: 20
            ),
            softWrap: true,
              maxLines: null,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(74, 169, 170, 1),
        child: Icon(Icons.add),
       // onPressed: _addDiaryPage,
      ),
    );
  }
}