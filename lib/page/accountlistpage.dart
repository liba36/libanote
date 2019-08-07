import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liba_note/utils/sqlhelper.dart';

import 'package:liba_note/page/editaccountpage.dart';


class accountistpage extends StatefulWidget {
  sqlhelper SQLUtils;
  int BookId;

  accountistpage(this.SQLUtils, this.BookId);

  State<StatefulWidget> createState() {
    return new _accountlistState();
  }
}

class _accountlistState extends State<accountistpage> {
  Color _defaultcolor = Color.fromRGBO(74, 169, 170, 1);

  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
         // appBar: _getappbar(_CheckBoxDisplay),
          body: _getBody(),
         // floatingActionButton: _getFloatButtopn(_CheckBoxDisplay),
        ),
        //onWillPop: _back
    );
  }

  _getBody(){
    return Container(

    );
  }

  _addAccount()
  {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new editaccountpage(1,widget.SQLUtils, _defaultcolor, null),
        )).then((data) {
    });
  }
}
