import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liba_note/model//diary.dart';
import 'package:liba_note/utils//sqlhelper.dart';

class editdiarypage extends StatefulWidget {
  sqlhelper _sqlhlper;
  String i1 = "";
  String i2 = "";
  Color defulcolor = Color.fromRGBO(74, 169, 170, 1);
  editdiarypage(this.i1, this.i2, this._sqlhlper, this.defulcolor);
  State<StatefulWidget> createState() {
    return new _editdiaryState(i1, i2, defulcolor);
  }
}

class _editdiaryState extends State<editdiarypage> {
  String _createres = "";
  String _path1 = "";
  String _listdiary = "";
  
  String _counter = "";
  String _context = "";
  String _title = "";
  Color _deafulcolor = Color.fromRGBO(74, 169, 170, 1);

  _editdiaryState(this._createres, this._path1, this._deafulcolor);

  //
  //
  _changetitle(String title) {
    _title = title;
  }

  _changecontext(String context) {
    _context = context;
    // _diary.context = context;
    setState(() {
      _counter = context.length.toString();
    });
  }

  Future _save() async {
    var _nowtime = DateTime.now();
    diary _temdiary = new diary(_title, _context, _nowtime, _nowtime);
    var res = await widget._sqlhlper.insertDiaryNote(_temdiary);
    setState(() {
      _createres = res.toString();
    });
  }

  Future _update() async {
    setState(() {
      _listdiary = "等待。。。";
    });
    List<Map> res = await widget._sqlhlper.getDiaryNote();
    if (res.length > 0) {
      String reslist = "";
      for (int i = 0; i < res.length; i++) {
        Map h = res[i];
        reslist += "title :";
        reslist += h["title"];
        reslist += "     context :";
        reslist += h["context"];
        reslist += "\n";
      }
      setState(() {
        _listdiary = reslist;
      });
    }

    setState(() {
      _path1 = widget._sqlhlper.path1;
      _createres = widget._sqlhlper.createres;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: new AppBar(
          title: new Text('添加'),
          backgroundColor: _deafulcolor,
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white, onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.done),
              color: Colors.white,
              onPressed: () => {_save(), Navigator.pop(context)},
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
                    cursorColor: _deafulcolor,
                    // cursorWidth: 10,
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: _deafulcolor, width: 2)),
                      contentPadding: EdgeInsets.all(5.0),
                      // icon: Icon(Icons.title),
                      labelText: '请输入title',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      //helperText: '不超过100字',
                      //counterText: '不超过100字',
                      //border: InputBorder.none,
                    ),
                    onChanged: _changetitle,
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
                          color: _deafulcolor,
                          width: 1,
                        )),
                    child: //输入内容
                        TextField(
                      cursorColor: _deafulcolor,
                      cursorWidth: 2,
                      style: TextStyle(fontSize: 15),
                      maxLines: null,
                      // keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        //   borderSide: BorderSide(
                        //     color: Color.fromRGBO(74, 169, 170, 1),
                        //     width: 1
                        //   ),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(5)),
                        //   borderSide: BorderSide(
                        //     color: Color.fromRGBO(74, 169, 170, 1),
                        //     width: 2
                        //   ),
                        // ),
                        contentPadding: EdgeInsets.all(10.0),
                        // icon: Icon(Icons.text_fields),
                        // labelText: '请输入内容',
                        labelStyle: TextStyle(
                            fontSize: 10, decorationColor: Colors.yellow),

                        //  helperText: '不超过1000字',
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
                    "$_counter",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),

                //  Text("error: $_createres \n path: $_path1"),
                //Text("结果是 ：\n $_listdiary"),
              ],
            )));
  }
}
