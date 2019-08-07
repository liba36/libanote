import 'package:flutter/material.dart';
import 'package:liba_note/utils/mulselectevent.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/model/account.dart';

class accountcard extends StatefulWidget {
  account AccountInstance;
  Color ColorDeful;
  bool CheckBoxDisplay = false;
  bool Checked = false;
  sqlhelper SqlUtils;

  accountcard(this.AccountInstance, this.ColorDeful, this.CheckBoxDisplay,
      this.SqlUtils);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _accountcardState();
  }
}

class _accountcardState extends State<accountcard> {
  @override
  initState() {
    super.initState();
  }

  _clik() {
    if (widget.CheckBoxDisplay == false) {
//      Navigator.push(
//          context,
//          new MaterialPageRoute(
//              builder: (context) =>
//              new diaryviewpage(widget.ColorDeful, widget.AccountInstance,widget.SqlUtils)));
    } else {
      setState(() {
        widget.Checked = !widget.Checked;
      });
      eventBus.fire(diaryslected(widget.Checked, widget.AccountInstance.id));
    }
  }

  _longclik() {
    if (widget.CheckBoxDisplay == false) {
      eventBus.fire(muldiaryselect(true));
      setState(() {
        widget.Checked = true;
      });
      eventBus.fire(diaryslected(widget.Checked, widget.AccountInstance.id));
    }
  }

  _getInterval() {
    if (widget.CheckBoxDisplay == false) {
      return EdgeInsets.all(8);
    } else {
      return EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15);
    }
  }

  _getColor(int type) //0 标题栏颜色 1 标题字体颜色 2 内容栏颜色 3 内容字体颜色 4 日期以及字数颜色
  {
    if (widget.CheckBoxDisplay == false) {
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
      if (widget.Checked == false) {
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

          ],
        ),
      ),
    );
  }
}
