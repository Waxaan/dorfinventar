import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
import 'package:http/http.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
  final controllerPrice = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', rightSymbol: "€");
  bool itemIsAvailable = true;

  @override
  void initState() {
    var _title = "";
    var _description = "";
    var _price = "0.00";
    controllerTitle.text = _title;
    controllerDescription.text = _description;
    controllerPrice.text = _price;
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
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: TextField(
            maxLength: 40,
            controller: controllerTitle,
            decoration: InputDecoration(
                labelText: "Titel des Inserats",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0))),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: CarouselSlider(
            height: 200.0,
            //create list with length(amount of pics already saved) + 1
            items: [for (var i = 0; i < model.getImagesLength() + 1; i += 1) i]
                .map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                      onTap: () async =>
                          model.addImage(context, await pickImage(i)),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.green),
                          child: model.getImage(
                              i,
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height)));
                },
              );
            }).toList(),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                        child: TextField(
                          controller: controllerPrice,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Preis",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0))),
                        ))),
                new DropdownButton<String>(
                    hint: Text("Kategorie"),
                    items: <String>['Outdoor', 'Elektronik', 'Umbau', 'Essen']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {}),
                Checkbox(
                  onChanged: (bool b) => {
                    setState(() {
                      itemIsAvailable = !itemIsAvailable;
                    })
                  },
                  value: itemIsAvailable,
                ),
                Text("Ist verfügbar")
              ],
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: TextField(
              controller: controllerDescription,
              decoration: InputDecoration(
                  labelText: "Beschreibung des Inserats",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0))),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
            )),
        Center(
            child: RaisedButton(
                onPressed: () {
                  model.postOffer(context,
                      title: controllerTitle.text,
                      description: controllerDescription.text,
                      price: 10.0,
                      category: "Outdoor");
                  Navigator.pop(context);
                },
                child: Text("Angebot einstellen")))
      ]);
    });
  }

  Future pickImage(int i) async {
    print("CarouselSliderClick on index " + i.toString());
    File file;
    print("newOfferPage: picking Image");
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (file != null) print("newOfferPage: Image successfully picked");
    return file;
  }

  changeItemAvailability() {
    itemIsAvailable = !itemIsAvailable;
  }
}

/**


 **/
