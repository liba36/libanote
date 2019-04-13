import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';

class diarycard extends StatefulWidget {
  diary DiaryInstance;
  Color ColorDeful;
  diarycard(this.DiaryInstance,this.ColorDeful);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _diarycardState();
  }
}

class _diarycardState extends State<diarycard> {
  // diarycard(this._diary);

  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Card(
        color: Color.fromRGBO(243, 246, 240, 1),
        elevation: 3,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                color: widget.ColorDeful,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 3,right: 3),
                child: Text(widget.DiaryInstance.title,style: TextStyle(fontSize: 18,color: Colors.white),)),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
              //color: Color.fromRGBO(250, 250, 250, 1),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.DiaryInstance.edittime.year.toString(),
                      style: TextStyle(color: Color.fromRGBO(173, 185, 190, 1)),
                    ),
                    margin: EdgeInsets.only(bottom: 10, top: 5, left: 20),
                  ),
                  Expanded(

                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 5, bottom: 5),
                      child: Text(
                        widget.DiaryInstance.context,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
