
import 'package:flutter/material.dart';

showSnackbar(BuildContext context, {String message}) {
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)));
}