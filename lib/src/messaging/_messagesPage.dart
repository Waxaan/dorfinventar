import 'package:flutter/material.dart';
import 'package:Dorfinventar/src/customDrawer.dart';
import 'messageCard.dart';

class MessagesPage extends StatefulWidget {
  final bool loggedIn;
  final String title;

  MessagesPage({Key key, this.title, this.loggedIn}) : super(key: key);

  @override
  _MessagesPage createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagesPage> {

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
      child: ListView(
        children: <Widget>[
          MessageCard(userIconID: "Test",username: "Franz-Joseph", preview: "Morgen Früh um 8 steht das dann abholbereit bei dir?", age: 10.0, id: "0",),
          MessageCard(userIconID: "Test",username: "Gertrud", preview: "Oh, vielen Danke", age: 75.0, id: "1"),
          MessageCard(userIconID: "Test",username: "Jochen", preview: "Hast du das auch in Blau?", age: 200.0, id: "2"),
          MessageCard(userIconID: "Test",username: "Dietah", preview: "Kannst du am Preis noch was machen?", age: 370.0, id: "3"),
          MessageCard(userIconID: "Test",username: "Helmut", preview: "Liefern Sie auch?", age: 621.0, id: "4"),
          MessageCard(userIconID: "Test",username: "Otto", preview: "Danke für den Spachtel", age: 5000, id: "5")
        ],
      ),
    );
  }
}
