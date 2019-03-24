import 'package:flutter/material.dart';

class notepage extends StatefulWidget{

  State<StatefulWidget> createState() {
    return new notepageState();
  }
}

class notepageState extends State<notepage>
{
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Text("this is note page"),
        ],
      ),
    );
  }
}