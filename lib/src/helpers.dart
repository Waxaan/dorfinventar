
import 'package:flutter/material.dart';

showSnackbar(BuildContext context, {String message, Color color}) {
  Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text(message, style: new TextStyle(color: color==null? Colors.white: Colors.black),),
        backgroundColor: color,
      )
  );
}