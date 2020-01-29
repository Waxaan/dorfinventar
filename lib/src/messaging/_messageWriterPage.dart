import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Dorfinventar/src/customDrawer.dart';
import 'package:Dorfinventar/src/messaging/messageTile.dart';
import 'package:Dorfinventar/src/helpers.dart';
import 'package:scoped_model/scoped_model.dart';

import '../userModel.dart';


class MessagesWriterPage extends StatefulWidget {
  final bool loggedIn;
  final String username;
  final String id;

  MessagesWriterPage({Key key, this.username, this.loggedIn, this.id }) : super(key: key);

  @override
  _MessagesWriterPage createState() => _MessagesWriterPage();
}

class _MessagesWriterPage extends State<MessagesWriterPage> {
  List<MessageTile> items = <MessageTile>[];
  final controllerMessage = TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  int start_index = 0;

  @override
  void initState() {
    var _message = "";
    List<MessageTile> items = <MessageTile>[];
    controllerMessage.text = _message;
    super.initState();
  }

  _addMessageToChat(String message) {
    setState(() {
      items.add(MessageTile(
        isuser: true,
        content: message,)
      );
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      Future.delayed(const Duration(milliseconds: 550), () {
        setState(() {
          items.add(_addResponseToChat(start_index));
          start_index += 1;
        });

      });
    });
  }

  _addResponseToChat(int index) {
    List<MessageTile> items = <MessageTile>[];
    items.addAll([
      MessageTile(isuser: false,
        content: "Ja klar, sehr gerne. Hast du denn auch nen Anhängerführerschein?",),
      MessageTile(isuser: false, content: "Ok, dann soll ja alles klappen. Eine Frage noch: Bist du neu hier?",),
      MessageTile(isuser: false, content: "Hast dir ne ruhige Gegend ausgesucht \nWo ziehst du denn hin?",),
      MessageTile(isuser: false, content: "Ach da! Da wohnt auch Tante Inge. Kennst du doch, oder?",),
      MessageTile(isuser: false, content: "Tante Inge! Die kennt man doch! Naja... kommst du dann hierher?",),
      MessageTile(isuser: false, content: "Ok, dann steht ja alles.",),
      MessageTile(isuser: false, content: "Bis später.",),
      MessageTile(isuser: false, content: "Immer wieder gerne!",),
    ]);
    print(index.toString());
    print(items.length.toString());
    if (index >= items.length-1) return items[items.length-1];
    return items[index];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Chat mit " + widget.username),
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*FutureBuilder(
                  future: model.retrieveConversationMessages(1),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return MessageTile(isuser: true,
                                    content: "Ich würde gerne deinen Spachtel ausleihen",
                                );
                              }
                          )
                      );
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ]);
                    }
                  }), */
              Expanded(
                child: ListView.builder(
                //controller: _scrollController,
                reverse: true,
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: items != null? items.length:0 ,
                itemBuilder: (context, index) {
                  return items[items.length-1 - index];
                },
                )
              ),
              Card(
                child: ListTile(
                  title: TextField(
                    controller: controllerMessage,
                  ),
                  trailing: FlatButton(
                    onPressed: () async {
                      _addMessageToChat(controllerMessage.text);
                      controllerMessage.text = "";
                      //showSnackbar(context, message: "Nachricht gesendet");
                    },
                    child: Icon(Icons.send)
                  )
                )
              )
            ],
          );})
        );
  }



  List<MessageTile> getItems(String username) {
    bool isuser = true;
  }
}
