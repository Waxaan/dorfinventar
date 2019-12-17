import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {

  CustomDrawer({Key key, this.loggedIn}) : super(key: key);
  bool loggedIn;

  @override
  Widget build(BuildContext context) {
    if (true) {
      return Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Dorfinventar",
                  textAlign: TextAlign.center,
                  style:
                  DefaultTextStyle
                      .of(context)
                      .style
                      .apply(fontSizeFactor: 2.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => Navigator.pushNamed(context, "/home"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.category),
                title: Text("Kategorie"),
                onTap: () => Navigator.pushNamed(context, "/categories"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.local_offer),
                title: Text("Meine Inserate"),
                onTap: () => Navigator.pushNamed(context, "/myOffers"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.message),
                title: Text("Nachrichten"),
                onTap: () => Navigator.pushNamed(context, "/messages"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Einstellungen"),
                onTap: () => Navigator.pushNamed(context, "/settings"),
              ),
            ],
          ));
    } else { // loggedIn False
      return Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Dorfinventar",
                  textAlign: TextAlign.center,
                  style:
                  DefaultTextStyle
                      .of(context)
                      .style
                      .apply(fontSizeFactor: 2.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => Navigator.pushNamed(context, "/home"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Anmelden"),
                onTap: () => Navigator.pushNamed(context, "/login"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Registrieren"),
                onTap: () => Navigator.pushNamed(context, "/register"),
              ),
            ],
          ));
    }
  }
}