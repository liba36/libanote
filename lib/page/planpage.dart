import 'package:flutter/material.dart';

class planpage extends StatefulWidget {
  String _time;
  String _title;
  String _context;

  planpage(this._time, this._title, this._context);

  State<StatefulWidget> createState() {
    return new stateplanpage();
  }
}

class stateplanpage extends State<planpage> {
  String tet = "初始化之前";
  @override
  void initState() {
    super.initState();
    setState(() {
      tet = "init aafter";
    });
  }

  _update1() {
    setState(() {
      tet = "anxiaqule";
    });
  }

  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        itemCount: 10,
        itemBuilder: (context, item) {
          return new Card(
            child: Text("asdasdd"),
          );
        },
      ),
    );
  }
}
