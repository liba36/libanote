import 'package:flutter/material.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/page/diarylistpage.dart';
import 'package:liba_note/model/book.dart';
import 'package:liba_note/page/accountlistpage.dart';

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

  _openBookPage() {
    switch (widget.BookInstance.type) {
      case 0:
       return Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new diarylistpage(
                    widget.SqlUtils, widget.BookInstance.id)));
      case 1:
       return Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new accountistpage(
                    widget.SqlUtils, widget.BookInstance.id)));
    }
  }

  @override
  initState() {
    super.initState();
  }

  Widget _getCardView() {
    return new GestureDetector(
        onTap: _openBookPage,
        // onLongPress: _showdi,
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2),
                child: _getImage(),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Text(
                  widget.BookInstance.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _getImage() {
    switch (widget.BookInstance.image) {
      case 0:
        return Image.asset(
          'assets/images/diary-b.png',
          fit: BoxFit.fill,
        );
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
    return _getCardView();
  }
}
