import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';

class diaryviewpage extends StatefulWidget {
  Color ColorDeful;
  diary DiaryInstance;

  diaryviewpage(this.ColorDeful, this.DiaryInstance);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _diaryviewState();
  }
}

class _diaryviewState extends State<diaryviewpage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          widget.DiaryInstance.edittime.year.toString() +
              "年" +
              widget.DiaryInstance.edittime.month.toString() +
              "月" +
              widget.DiaryInstance.edittime.day.toString() +
              "日 " +
              widget.DiaryInstance.edittime.hour.toString() +
              ":" +
              widget.DiaryInstance.edittime.second.toString(),
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
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
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.ColorDeful,
                  width: 1
                )
              )
            ),
            margin: EdgeInsets.only(left: 18, right: 18,top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.DiaryInstance.title,
              style: TextStyle(
                fontSize: 23,
                color: Color.fromRGBO(66, 66, 66, 1)
              ),
              softWrap: true,
              maxLines: null,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              widget.DiaryInstance.context,
              style: TextStyle(fontSize: 18,color: Color.fromRGBO(99, 99, 99, 1)),
              softWrap: true,
              maxLines: null,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(74, 169, 170, 1),
        child: Icon(Icons.edit),
        // onPressed: _addDiaryPage,
      ),
    );
  }
}
