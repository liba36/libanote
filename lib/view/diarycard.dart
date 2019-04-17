import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/page/diaryviewpage.dart';

class diarycard extends StatefulWidget {
  diary DiaryInstance;
  Color ColorDeful;
  final CallBack;
  bool CheckBoxDisplay;
  bool Checked;

  diarycard(this.DiaryInstance, this.ColorDeful,this.CallBack);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _diarycardState();
  }
}

class _diarycardState extends State<diarycard> {
  // diarycard(this._diary);
  _clik() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new diaryviewpage(widget.ColorDeful, widget.DiaryInstance)));
  }

  _longclik()
  {
    widget.CallBack();
    setState(() {
      widget.ColorDeful = Colors.red;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _clik,
      onLongPress: _longclik,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: widget.ColorDeful,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                ),
                // color: widget.ColorDeful,
                alignment: Alignment.center,
                //margin: EdgeInsets.all(3),
                padding: EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 3),
                child: Text(
                  widget.DiaryInstance.title,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                widget.DiaryInstance.context,
                style: TextStyle(
                    color: Color.fromRGBO(122, 123, 122, 1),
                    fontSize: 15,
                    wordSpacing: 1.36,
                    letterSpacing: 0.36,
                    height: 1.36),
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("字数：" + widget.DiaryInstance.context.length.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(136, 136, 136, 1))),
                  Text(
                    widget.DiaryInstance.edittime.year.toString() +
                        "/" +
                        widget.DiaryInstance.edittime.month.toString() +
                        "/" +
                        widget.DiaryInstance.edittime.day.toString(),
                    style: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(136, 136, 136, 1)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
