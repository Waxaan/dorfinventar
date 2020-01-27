import 'package:Dorfinventar/src/my_offer/_newOfferPage.dart';
import 'package:camera/camera.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/material.dart';
import 'src/auth/_startPage.dart';
import 'src/auth/_loginPage.dart';
import 'src/auth/_registerPage.dart';
import 'src/public_offers/_homePage.dart';
import 'src/public_offers/_categoryPage.dart';
import 'src/public_offers/_subCategoryPage.dart';
import 'src/my_offer/_newOfferPage.dart';
import 'src/messaging/_messagesPage.dart';
import 'src/_settingsPage.dart';
import 'src/_subSettingPage.dart';
import 'src/public_offers/_offerPage.dart';
import 'src/messaging/_privateMessagesPage.dart';
import 'src/my_offer/_myOffersPage.dart';
import 'src/profile/_profilePage.dart';
import 'src/profile/_alienProfilePage.dart';
import 'src/userModel.dart';
import 'src/sensors/_cameraPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  UserModel userModel = new UserModel();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    userModel.setCategories();
    return ScopedModel<UserModel>(
      model: userModel,
      child: MaterialApp(
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
          "/camera": (context) => CameraPage()
        },
      )
    );
  }
}
