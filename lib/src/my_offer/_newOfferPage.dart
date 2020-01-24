import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
import 'package:http/http.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

import '../userModel.dart';

class NewOfferPage extends StatefulWidget {
  NewOfferPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewOfferPage createState() => _NewOfferPage();
}

class _NewOfferPage extends State<NewOfferPage> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  void initState() {
    var _title = "";
    var _description = "";
    controllerTitle.text = _title;
    controllerDescription.text = _description;
    super.initState();
  }

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
    return ScopedModelDescendant <UserModel>(
        builder: (context, child, model) {
          return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: TextField(
                    maxLength: 120,
                    controller: controllerTitle,
                    decoration: InputDecoration(
                        helperText: "Titel des Inserats"),),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: GestureDetector(
                      onTap: () => pickImage(),
                      child: Image(
                        image: AssetImage('graphics/smartphone.png'),
                        height: 250,),
                    )
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: TextField(
                      controller: controllerDescription,
                      decoration: InputDecoration(
                          helperText: "Beschreibung des Inserats"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,)
                ),
                Center(
                    child: RaisedButton(
                        onPressed: () {
                          model.postOffer(context, title: controllerTitle.text, description:controllerDescription.text,
                          price: 10.0, category: "Outdoor");
                          Navigator.pop(context);
                        },
                        child: Text("Angebot einstellen")
                    )
                )
              ]
          );
        }
    );
  }

  pickImage() async {
    File file;
    print("newOfferPage: picking Image");
    file = await ImagePicker.pickImage(source: ImageSource.camera);
  }

  }
