import 'dart:math';

import 'package:flutter/material.dart';
import 'customDrawer.dart';

class OfferPage extends StatefulWidget {

  OfferPage({Key key, this.title, this.description}) : super(key: key);
  final String title;
  final String description;

  @override
  _OfferPage createState() => _OfferPage();
}

class _OfferPage extends State<OfferPage> {

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
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  Image(
                      image: getRandomImage()),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Vormerken"),
                        onPressed: () {},),
                      RaisedButton(
                        child: Text("Verkäufer"),
                        onPressed: () {},),
                      RaisedButton(
                        child: Text("Nachricht"),
                        onPressed: () {},),
                    ],
                  ),
                ],

              ),
            ),
            Text(widget.title,
              style: TextStyle(fontSize: 24)),
            Text(widget.description)
          ],
        ),
      )
    );
  }

  getRandomImage() {
    Random random = new Random();
    int num = random.nextInt(5);
    if (num == 0) {
      return AssetImage('graphics/arkani.png');
    } else if (num == 1) {
      return AssetImage('graphics/brownie.png');
    } else if (num == 2) {
      return AssetImage('graphics/cat.png');
    } else if (num == 3) {
      return AssetImage('graphics/cookies.png');
    } else if (num == 4) {
      return AssetImage('graphics/smartphone.png');
    } else {
      return AssetImage('400x400_placeholder.png');
    }
  }
}
