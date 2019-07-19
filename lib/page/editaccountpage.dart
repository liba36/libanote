import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liba_note/model/diary.dart';
import 'package:liba_note/utils/sqlhelper.dart';

class editaccountpage extends StatefulWidget {
  int Type; //0 edit 1 add
  sqlhelper _sqlhlper;
  Color ColorDeful;
  diary DiaryInstance;

  editaccountpage(
      this.Type, this._sqlhlper, this.ColorDeful, this.DiaryInstance);

  State<StatefulWidget> createState() {
    return new _editaccountState();
  }
}

class _editaccountState extends State<editaccountpage> {
  String _AccountName = "新的账户";
  String _AccountID = "";
  String _AccountPWD = "";
  bool _ObscureText = true;
  Icon _PwdView = Icon(Icons.visibility);

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  _getAppBar() {
    return AppBar(
      title: new Text(
        _getAppbarTitle(),
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
          // onPressed: _reset,
        ),
        IconButton(
          icon: Icon(Icons.done),
          color: widget.ColorDeful,
          //onPressed:_save,
        ),
      ],
    );
  }

  _getAppbarTitle() {
    if (0 == widget.Type)
      return "编辑";
    else
      return "添加";
  }

  _getBody() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            child: TextField(
              maxLength: 15,
              //光标
              cursorColor: widget.ColorDeful,
              // cursorWidth: 10,
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: '请输入名称:',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.title,
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
              onChanged: _setAccountName,
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 10),
            elevation: 10,
            child: TextField(
              //光标
              cursorColor: widget.ColorDeful,
              // cursorWidth: 10,
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入账户名:',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.perm_identity,
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
              onChanged: _setAccountName,
            ),
          ),
          Card(
            margin: EdgeInsets.only(bottom: 10),
            elevation: 10,
            child: TextField(
              cursorColor: widget.ColorDeful,
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              obscureText: _ObscureText,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '请输入密码:',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.vpn_key,
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
              onChanged: _setAccountName,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(icon: _PwdView, onPressed: _changeObscureText),
              IconButton(icon: Icon(Icons.content_copy),onPressed: _changeObscureText),
            ],
          ),
        ],
      ),
    );
  }

  _setAccountID(String data) {
    setState(() {
      _AccountID = data;
    });
  }

  _setAccountName(String data) {
    setState(() {
      _AccountName = data;
    });
  }

  _changeObscureText() {
    if (true == _ObscureText)
      setState(() {
        _PwdView = Icon(Icons.visibility);
        _ObscureText = false;
      });
    else
      setState(() {
        _PwdView = Icon(Icons.visibility_off);
        _ObscureText = true;
      });
  }
}
