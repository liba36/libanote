import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';

class diarycard extends StatelessWidget {
  diary _diary;
  diarycard(this._diary);

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _diary.createtime.year.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    _diary.createtime.month.toString(),
                    style: TextStyle(fontSize: 9),
                  ),
                  Text(
                    _diary.createtime.day.toString(),
                    style: TextStyle(//color: Color.fromRGBO(173, 185, 190, 1),
                    fontSize: 8),
                  ),
                ],
              )),
          Expanded(
            child: Card(
              margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
              color: Color.fromRGBO(250, 250, 250, 1),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      _diary.title,
                      style: TextStyle(color: Color.fromRGBO(173, 185, 190, 1)),
                    ),
                    margin: EdgeInsets.only(bottom: 10, top: 5, left: 20),
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 5,bottom: 5),
                    child: Text(
                    _diary.context,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
