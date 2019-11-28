import 'package:flutter/material.dart';
import 'customDrawer.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: _settingsWidget(),
    );
  }


  Widget _settingsWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Eigene Angaben"); },
                leading: Icon(Icons.contact_mail),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Eigene Angaben"),
                ),
                subtitle: Text("Name, Email, Passwort",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Benachrichtigungen"); },
                leading: Icon(Icons.notifications_active),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Benachrichtigungen"),
                ),
                subtitle: Text("Nachrichten, Angebote, Verkäufe",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Chats"); },
                leading: Icon(Icons.message),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Chats"),
                ),
                subtitle: Text("Verlauf löschen, Backups",),
              ),

            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Hilfe"); },
                leading: Icon(Icons.help),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Hilfe"),
                ),
                subtitle: Text("Was ist eigentlich ...",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("App Teilen"); },
                leading: Icon(Icons.share),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("App Teilen"),
                ),
                subtitle: Text("Lad deine Freunde und Nachbarn ein",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Über die App"); },
                leading: Icon(Icons.perm_device_information),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Über die App"),
                ),
                subtitle: Text("Versionen, Updates",),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePage(pageTitle) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => SettingsPage(title: pageTitle,)),
    );
  }
}
