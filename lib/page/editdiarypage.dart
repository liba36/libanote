import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/utils/sqlhelper.dart';
import 'package:liba_note/page/diarylistpage.dart';

class editdiarypage extends StatefulWidget {
  int Type; //0 edit 1 add
  sqlhelper _sqlhlper;
  Color ColorDeful;
  diary DiaryInstance;

  editdiarypage(this.Type, this._sqlhlper, this.ColorDeful, this.DiaryInstance);

  State<StatefulWidget> createState() {
    return new _editdiaryState();
  }
}

class _editdiaryState extends State<editdiarypage> {
  String _context = "";
  String _title = "";
  String _appbartitle = "";

  @override
  initState() {
    super.initState();
    _reset();
  }

  _reset() {
    if (widget.Type == 0) {
      setState(() {
        _title = widget.DiaryInstance.title;
        _context = widget.DiaryInstance.context;
        _appbartitle = "编辑";
      });
    } else {
      setState(() {
        _title = "";
        _context = "";
        _appbartitle = "添加";
      });
    }
  }

  _changetitle(String title) {
    _title = title;
  }

  _changecontext(String context) {
    setState(() {
      _context = context;
    });
  }

  Future _save() async {
    var _nowtime = DateTime.now();
    widget.DiaryInstance.title = _title;
    widget.DiaryInstance.context = _context;
    widget.DiaryInstance.edittime = _nowtime;
    if (widget.Type == 1) {
      widget.DiaryInstance.createtime = _nowtime;
      widget._sqlhlper.insertDiary(widget.DiaryInstance);
    } else {
      widget._sqlhlper.updateDiary(widget.DiaryInstance);
    }
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: new AppBar(
          title: new Text(
            _appbartitle,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: widget.ColorDeful,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              color: widget.ColorDeful,
              onPressed: _reset,
            ),
            IconButton(
              icon: Icon(Icons.done),
              color: widget.ColorDeful,
              onPressed: _save,
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 18, right: 18, top: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //输入title
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: TextField(
                    maxLength: 10,
                    //光标
                    cursorColor: widget.ColorDeful,
                    // cursorWidth: 10,
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: widget.ColorDeful, width: 2)),
                      contentPadding: EdgeInsets.all(5.0),
                      // icon: Icon(Icons.title),
                      labelText: '请输入标题：',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      //helperText: '不超过100字',
                      //counterText: '不超过100字',
                      //border: InputBorder.none,
                    ),
                    onChanged: _changetitle,
//设置光标一直在最后
//                    controller: TextEditingController.fromValue(
//                        TextEditingValue(
//                            text: _title,
//                            //设置光标
//                            selection: TextSelection.fromPosition(TextPosition(
//                                affinity: TextAffinity.downstream,
//                                offset: _title.length)))),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(top: 18, left: 5, right: 5),
                    constraints: BoxConstraints(
                        //子部件最小高度
                        minHeight: 200),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: widget.ColorDeful,
                          width: 1,
                        )),
                    child: //输入内容
                        TextField(
                      cursorColor: widget.ColorDeful,
                      cursorWidth: 2,
                      style: TextStyle(fontSize: 15),
                      maxLines: null,
                      // keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelStyle: TextStyle(
                            fontSize: 10, decorationColor: Colors.yellow),
                        hintText: "你在想什么...",
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: _changecontext,
                    )),

                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    _context.length.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            )));
  }
}
