import 'package:camera/camera.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/material.dart';
import 'src/_startPage.dart';
import 'src/_loginPage.dart';
import 'src/_registerPage.dart';
import 'src/_homePage.dart';
import 'src/_categoryPage.dart';
import 'src/_subCategoryPage.dart';
import 'src/_newOfferPage.dart';
import 'src/_messagesPage.dart';
import 'src/_settingsPage.dart';
import 'src/_subSettingPage.dart';
import 'src/_offerPage.dart';
import 'src/_privateMessagesPage.dart';
import 'src/_myOffersPage.dart';
import 'src/_profilePage.dart';
import 'src/_alienProfilePage.dart';

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
        "/subcategories": (context) => SubCategoryPage(title: "Unterkategorie"),
        "/myOffers": (context) => MyOffersPage(title: "Meine Inserate",),
        "/newOffer": (context) => NewOfferPage(title: "Neues Inserat",),
        "/offerPage": (context) => OfferPage(title: "Inserat: ____",),
        "/messages": (context) => MessagesPage(title: "Nachrichten",),
        "/privateMessages": (context) => PrivateMessagesPage(title: "Ausleihen von _____",),
        "/settings": (context) => SettingsPage(title: "Einstellungen",),
        "/subsettings": (context) => SubSettingsPage(title: "Untereinstellungen",),
        "/profile": (context) => ProfilePage(title: "Profil",),
        "/alienProfile": (context) => AlienProfilePage(title: "Profil von ___",),
      },
    );
  }
}
