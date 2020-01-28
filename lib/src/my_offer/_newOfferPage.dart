import 'dart:io';

import 'package:Dorfinventar/src/helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
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
      decimalSeparator: '.', thousandSeparator: ',', rightSymbol: "€");
  bool itemIsAvailable = true;
  var _category = "Kategorie";

  int getControllerPrice() {
    String _price = controllerPrice.text.replaceAll(new RegExp(r'[^\w\s]+'),'');
    return int.parse(_price);
  }

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
                Listener(
                    onPointerDown: (_) => FocusScope.of(context).unfocus(),
                    child: DropdownButton<String>(
                      hint: Text(_category),
                      items: model.getCategoryList().map<DropdownMenuItem<String>>((value) =>
                      new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      )
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    )),
                Checkbox(
                  onChanged: (bool b) => {
                    setState(() {
                      itemIsAvailable = !itemIsAvailable;
                    })
                  },
                  value: itemIsAvailable,
                ),
                Text("Verfügbar")
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
                  if (areInputsValid(context, controllerTitle.text, controllerDescription.text, _category)) {
                    model.postOffer(context,
                      title: controllerTitle.text,
                      description: controllerDescription.text,
                      price: getControllerPrice(),
                      category: model.getCategoryDetail()[_category + "_id"],
                      available: !itemIsAvailable);
                    Navigator.pop(context);
                  }
                },
                child: Text("Angebot einstellen")))
      ]);
    });
  }

  Future pickImage(int i) async {
    print("CarouselSliderClick on index " + i.toString());
    File file;
    print("newOfferPage: picking Image");
    file = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 690, maxHeight: 690);
    if (file != null) print("newOfferPage: Image successfully picked");
    return file;
  }

  bool areInputsValid(BuildContext context, String title, String desc, String category) {
    if(title.length < 1) {
      showSnackbar(context, message: "Es wurde kein Titel gesetzt.", color: Colors.red);
      return false;
    }
    if(category == "Kategorie") {
      showSnackbar(context, message: "Es wurde keine Kategorie gesetzt.", color: Colors.red);
      return false;
    }
    if(desc.length < 1) {
      showSnackbar(context, message: "Es wurde keine Beschreibung gesetzt.", color: Colors.red);
      return false;
    }
    print("$title, $desc, $category");
    return true;
  }
}
