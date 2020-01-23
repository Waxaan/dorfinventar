import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Dorfinventar/src/customDrawer.dart';
import 'package:Dorfinventar/src/messaging/messageTile.dart';
import 'package:Dorfinventar/src/helpers.dart';


class MessagesWriterPage extends StatefulWidget {
  final bool loggedIn;
  final String username;
  final String id;

  MessagesWriterPage({Key key, this.username, this.loggedIn, this.id }) : super(key: key);

  @override
  _MessagesWriterPage createState() => _MessagesWriterPage(username);
}

class _MessagesWriterPage extends State<MessagesWriterPage> {
  List<MessageTile> items;
  _MessagesWriterPage(String username) {
    items = getItems(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Chat mit " + widget.username),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            },
            )
          ),
          Card(
            child: ListTile(
              title: TextField(),
              trailing: FlatButton(
                onPressed: () => showSnackbar(context, message: "Nachricht gesendet"),
                child: Icon(Icons.send)
              )
            )
          )
        ],
      ),
    );
  }



  List<MessageTile> getItems(String username) {
    Random random = new Random();
    bool isuser = true;
    List<MessageTile> items = <MessageTile>[];
    items.addAll([
      MessageTile(isuser: isuser,
        content: "Ich würde gerne deinen Spachtel ausleihen",),
      MessageTile(isuser: !isuser, content: "Ok, hast du noch irgendwelche Fragen?",),
      MessageTile(isuser: isuser, content: "Ab wann kann ich den holen? Ist relativ dringend; "
            "der Putz ist schon angemischt und wird gleich im Eimer wieder hart",),
      MessageTile(isuser: !isuser, content: "Hmm. Wenns so dringend ist, kannst du gleich vorbei kommen",),
      MessageTile(isuser: isuser, content: "Dann bis gleich",),
      MessageTile(isuser: isuser, content: "Danke für den Spachtel",),
      MessageTile(isuser: !isuser, content: "Immer wieder gerne!",),
    ]);
    return items;
/*
    items[1].addAll([
      MessageTile(username: username,
        content: "Steht das Palettenbett noch zu verkauf?",),
      MessageTile(
        username: _myName, content: "Ja, klar, aber der Andrang ist hoch!",),
      MessageTile(
        username: username, content: "Echt? Was ist der letzte Preis?",),
      MessageTile(username: _myName, content: "35€",),
      MessageTile(username: username, content: "Dann würd ich dir 40€ geben.",),
      MessageTile(username: _myName,
        content: "Ich schau mal, was die andere Person sagt (:",),
      MessageTile(username: username, content: "Ok",),
    ]);
    return items[random.nextInt(2)]; */
  }
}
