import 'package:flutter/material.dart';
import 'customDrawer.dart';
import 'messageCard.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key key, this.title}) : super(key: key);
  final String title;

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
          MessageCard(userIconID: "Test",username: "Franz-Joseph", preview: "Morgen Früh um 8 steht das dann abholbereit bei dir?", age: 10.0,),
          MessageCard(userIconID: "Test",username: "Gertrud", preview: "Oh, vielen Danke", age: 75.0,),
          MessageCard(userIconID: "Test",username: "Jochen", preview: "Hast du das auch in Blau?", age: 200.0,),
          MessageCard(userIconID: "Test",username: "Dietah", preview: "Kannst du am Preis noch was machen?", age: 370.0,),
          MessageCard(userIconID: "Test",username: "Helmut", preview: "Liefern Sie auch?", age: 621.0,),
          MessageCard(userIconID: "Test",username: "Otto", preview: "Danke für den Spachtel", age: 5000,)
        ],
      ),
    );
  }
}
