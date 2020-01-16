import 'package:flutter/material.dart';
import 'customDrawer.dart';
import 'package:http/http.dart';
import 'package:camera/camera.dart';

class NewOfferPage extends StatefulWidget {
  NewOfferPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewOfferPage createState() => _NewOfferPage();
}

class _NewOfferPage extends State<NewOfferPage> {

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
    var ControllerTitle = TextEditingController();
    var ControllerDescription = TextEditingController();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: TextField(
            maxLength: 120,
            controller: ControllerTitle,
            decoration: InputDecoration(helperText: "Titel des Inserats"),),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/camera"),
            child: Image(
              image: AssetImage('graphics/smartphone.png'), height: 250,),
          )
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: TextField(
            controller: ControllerDescription,
            decoration: InputDecoration(
                helperText: "Beschreibung des Inserats"),
            keyboardType: TextInputType.multiline,
            maxLines: null,)
        ),
        Center(
          child: Row(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  onPressed: (){
                    send_Input_to_server(ControllerTitle.text, ControllerDescription.text);
                    Navigator.pop(context);
                  },
                 child: Text("Angebot einstellen")
                )
              )
            ]
          )
        ),

      ]
    );
  }

  void send_Input_to_server(String text, String text2) {}
}
