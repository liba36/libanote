import 'package:flutter/material.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/page/diarylistpage.dart';
import 'package:liba_note/model/book.dart';

class bookcard extends StatefulWidget {
  sqlhelper SqlUtils;
  book BookInstance;

  bookcard(this.SqlUtils, this.BookInstance);

  @override
  State<StatefulWidget> createState() {
    return _bookcarState();
  }
}

class _bookcarState extends State<bookcard> {
  _editdiarypage() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new diarylistpage(widget.SqlUtils)));
  }

  @override
  initState() {
    super.initState();
  }

  Widget _getdiarybook() {
    switch (widget.BookInstance.image) {
      case -1:
        return new GestureDetector(
            onTap: _editdiarypage,
            // onLongPress: _showdi,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  child: new Image.asset(
                    'assets/images/diary-b.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Text(widget.BookInstance.name),
              ],
            ));
      default:
        return new GestureDetector(
            onTap: _editdiarypage,
            // onLongPress: _showdi,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  child: new Image.asset(
                    'assets/images/diary-b.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Text(""),
              ],
            ));
    }
  }

  Widget _getitem() {
    switch (widget.BookInstance.type) {
      case 0:
        return _getdiarybook();
      case 1:
      case 2:
      case 3:
      case 4:
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _editdiarypage,
        // onLongPress: _showdi,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              child: new Image.asset(
                'assets/images/diary-b.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text(
                widget.BookInstance.name,
                // softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
    ;
  }
}
