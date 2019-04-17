import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/page/diaryviewpage.dart';
import 'package:liba_note/utils/mulselectevent.dart';


class diarycard extends StatefulWidget {
  diary DiaryInstance;
  Color ColorDeful;
  final CallBack;

  bool Checked;

  diarycard(this.DiaryInstance, this.ColorDeful, this.CallBack);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _diarycardState();
  }
}

class _diarycardState extends State<diarycard> {
  // diarycard(this._diary);
  bool _CheckBoxDisplay = false;
  bool _Checked = false;

  @override
  initState() {
    super.initState();
    eventBus.on<muldiaryselect>().listen(
        (muldiaryselect statu) => _setCheckBoxDisplay(statu.MulSelectEndable));
  }

  _setCheckBoxDisplay(bool statu) {
    if (statu == true) {
      setState(() {
        _CheckBoxDisplay = statu;
      });
    } else {
      setState(() {
        _CheckBoxDisplay = statu;
        _Checked = false;
      });
    }
  }

  _clik() {
    if (_CheckBoxDisplay == false) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  new diaryviewpage(widget.ColorDeful, widget.DiaryInstance)));
    } else {
      setState(() {
        _Checked = !_Checked;
      });
    }
  }

  _longclik() {
    widget.CallBack();
    setState(() {
      _Checked = true;
    });
  }

  _getInterval() {
    if (_CheckBoxDisplay == false) {
      return EdgeInsets.all(8);
    } else {
      return EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15);
    }
  }

  _getColor(int type) //0 标题栏颜色 1 标题字体颜色 2 内容栏颜色 3 内容字体颜色 4 日期以及字数颜色
  {
    if (_CheckBoxDisplay == false) {
      switch (type) {
        case 0:
          return widget.ColorDeful;
        case 1:
          return Colors.white;
        case 2:
          return Colors.white;
        case 3:
          return Color.fromRGBO(122, 123, 122, 1);
        case 4:
          return Color.fromRGBO(136, 136, 136, 1);
        default:
          return widget.ColorDeful;
      }
    } else {
      if (_Checked == false) {
        switch (type) {
          case 0:
            return Colors.grey;
          case 1:
            return Colors.white;
          case 2:
            return Colors.white;
          case 3:
            return Colors.grey;
          case 4:
            return Color.fromRGBO(96, 96, 96, 1);
          default:
            return widget.ColorDeful;
        }
      } else {
        switch (type) {
          case 0:
            return Colors.red;
          case 1:
            return Colors.white;
          case 2:
            return Colors.white;
          case 3:
            return Colors.grey;
          case 4:
            return Color.fromRGBO(96, 96, 96, 1);
          default:
            return widget.ColorDeful;
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _clik,
      onLongPress: _longclik,
      child: Card(
        elevation: 3,
        margin: _getInterval(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: _getColor(0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 3),
                child: Text(
                  widget.DiaryInstance.title,
                  style: TextStyle(fontSize: 18, color: _getColor(1)),
                )),
            Container(
              color: _getColor(2),
              margin: EdgeInsets.all(5),
              child: Text(
                widget.DiaryInstance.context,
                style: TextStyle(
                    color: _getColor(3),
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
                      style: TextStyle(fontSize: 10, color: _getColor(4))),
                  Text(
                    widget.DiaryInstance.edittime.year.toString() +
                        "/" +
                        widget.DiaryInstance.edittime.month.toString() +
                        "/" +
                        widget.DiaryInstance.edittime.day.toString(),
                    style: TextStyle(fontSize: 10, color: _getColor(4)),
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
