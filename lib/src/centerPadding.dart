import 'package:flutter/material.dart';

class CenterPadding extends Center {
  CenterPadding({Key key, this.children}) : super(key: key);
  final List<Widget> children;

  Widget build(BuildContext context) {
    print("Test");
    print(this.children);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Text("test")
          ]
        ),
      ),
    );
  }
}