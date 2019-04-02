import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addbookpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _addbookState();
  }
}

class _addbookState extends State<addbookpage> {
  Color _defulcolor = Color.fromRGBO(74, 169, 170, 1);
  String _title = "新的本子哟";
  int _selectvalue;

  List<DropdownMenuItem> _getDdmItem() {
    final List<DropdownMenuItem> _DdmItem = List();
    final DropdownMenuItem _item1 =
        DropdownMenuItem(value: 0, child: Text("日记"));
    final DropdownMenuItem _item2 =
        DropdownMenuItem(value: 1, child: Text("计划"));
    final DropdownMenuItem _item3 =
        DropdownMenuItem(value: 2, child: Text("账本"));
    final DropdownMenuItem _item4 =
        DropdownMenuItem(value: 3, child: Text("密码本"));
    final DropdownMenuItem _item5 =
        DropdownMenuItem(value: 4, child: Text("课程表"));
    _DdmItem.add(_item1);
    _DdmItem.add(_item2);
    _DdmItem.add(_item3);
    _DdmItem.add(_item4);
    _DdmItem.add(_item5);
    return _DdmItem;
  }

  _changeType(T) {
    setState(() {
      _selectvalue = T;
    });
  }
  _changeTitle(T){
    if("" !=  T) {
      setState(() {
        _title = T;
      });
    }
    else
      {
        setState(() {
          _title = "新的本子哟";
        });
      }
  }

  Widget _getimage() {
    return new Image.asset(
      'assets/images/diary-y.png',
      height: 153.55,
      width: 109.25,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: _defulcolor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 36, right: 36, top: 10, bottom: 10),
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(
                  //子部件最小高度
                  minHeight: 200,
                  minWidth: 200),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: _defulcolor,
                    width: 1,
                  )),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _getimage(),
                  Text(_title),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "本子类型：",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                      hint: Text(
                        "请选择本子类型",
                      ),
                      items: _getDdmItem(),
                      onChanged: _changeType,
                      value: _selectvalue,
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              child: TextField(
                maxLength: 20,
                //光标
                cursorColor: _defulcolor,
                // cursorWidth: 10,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _defulcolor, width: 2)),
                  contentPadding: EdgeInsets.all(5.0),
                  // icon: Icon(Icons.title),
                  labelText: '请输入名称',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                onChanged: _changeTitle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _defulcolor,
        // onPressed: _editdiarypage1,
        tooltip: '提交', //长按显示的文字
        child: Icon(Icons.done),
      ),
    );
  }
}
