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
    final DropdownMenuItem _item1 = DropdownMenuItem(
        value: 0,
        child: Text(
          "日记",
          style: TextStyle(fontSize: 15),
        ));
    final DropdownMenuItem _item2 = DropdownMenuItem(
        value: 1,
        child: Text(
          "计划",
          style: TextStyle(fontSize: 15),
        ));
    final DropdownMenuItem _item3 = DropdownMenuItem(
        value: 2,
        child: Text(
          "账本",
          style: TextStyle(fontSize: 15),
        ));
    final DropdownMenuItem _item4 = DropdownMenuItem(
        value: 3,
        child: Text(
          "密码本",
          style: TextStyle(fontSize: 15),
        ));
    final DropdownMenuItem _item5 = DropdownMenuItem(
        value: 4,
        child: Text(
          "课程表",
          style: TextStyle(fontSize: 15),
        ));
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

  _changeTitle(T) {
    if ("" != T) {
      setState(() {
        _title = T;
      });
    } else {
      setState(() {
        _title = "新的本子哟";
      });
    }
  }

  _changeContext(T) {}

  _save() {}

  Widget _getimage() {
    return new Image.asset(
      'assets/images/diary-b.png',
      height: 110.195,//0.036
      width: 78.66,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: Text(
          "新建本子",
          style: TextStyle(fontSize: 17),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: _defulcolor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: _defulcolor,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.done),
            color: _defulcolor,
            onPressed: () => {_save(), Navigator.pop(context)},
          ),
        ],
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
                 // minHeight: 136,
                  minWidth: 150
              ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      "本子类型：",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                      hint: Text(
                        "请选择本子类型",
                        style: TextStyle(fontSize: 15),
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
            Container(
                margin: EdgeInsets.only(top: 5, left: 25, right: 25),
                constraints: BoxConstraints(
                    //子部件最小高度
                    minHeight: 136),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: _defulcolor,
                      width: 1,
                    )),
                child: //输入内容
                    TextField(
                  cursorColor: _defulcolor,
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
                    labelStyle:
                        TextStyle(fontSize: 10, decorationColor: Colors.yellow),

                    //  helperText: '不超过1000字',
                    hintText: "本子的描述...",
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: _changeContext,
                )),
          ],
        ),
      ),
    );
  }
}
