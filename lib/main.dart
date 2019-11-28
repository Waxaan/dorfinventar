import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'src/start.dart';
import 'src/login.dart';
import 'src/register.dart';
import 'src/home.dart';
import 'src/categories.dart';
import 'src/myOffers.dart';
import 'src/newOffer.dart';
import 'src/messages.dart';
import 'src/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dorfinventar',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        "/": (context) => StartPage(title: "Dorfinventar"),
        "/login": (context) => LoginPage(title: "Dorfinventar"),
        "/register": (context) => RegisterPage(title: "Dorfinventar"),
        "/home": (context) => HomePage(title: "Dorfinventar",),
        "/categories": (context) => CategoryPage(title: "Kategorien"),
        "/myOffers": (context) => MyOffersPage(title: "Meine Inserate",),
        "/newOffer": (context) => NewOfferPage(title: "Neues Inserat",),
        "/messages": (context) => MessagesPage(title: "Nachrichten",),
        "/settings": (context) => SettingsPage(title: "Settings",),
      },
    );
  }
}
