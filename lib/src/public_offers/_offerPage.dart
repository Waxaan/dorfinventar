import 'dart:core';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../userModel.dart';

class OfferPage extends StatefulWidget {

  OfferPage({Key key, this.title, this.description, this.owner, this.price, this.category, this.articleID, this.isActive, })
      : super(key: key);
  final String title;
  final String description;
  final String owner;
  final String price;
  final String category;
  final int articleID;
  final String isActive;
  int _selectedIndex = 1;



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
      body: _settingsWidget(),
    );
  }

  Widget _settingsWidget() {


    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Column(children: <Widget>[
        Expanded(
            child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
            child: CarouselSlider(
              height: 250.0,
              items: [for (var i = 0; i < 0 + 1; i += 1) i].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                        onTap: () async => {},
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
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                children: <Widget>[
                  Card(
                      color: Colors.white54,
                      elevation: 3,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text(widget.price, style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      )
                  ),
                  Card(
                      color: Colors.white54,
                      elevation: 3,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text(widget.category.toString(), style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      )
                  ),
                  Card(
                      color: (widget.isActive == 'active')? Colors.green : Colors.red,
                      elevation: 3,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text((widget.isActive == 'active')? "Verfügbar" : "Verkauft",
                            style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      )
                  ),
                ],
              )),),
          Container(
            child:Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Card(
                color: Colors.white,
                elevation: 3,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Text(widget.description,
                      style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                )
            ),
          ),
          )
        ])),
        BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              title: Text('Vormerken'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Verkäufer'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_post_office),
              title: Text('Nachricht'),
            ),],
          currentIndex: widget._selectedIndex,
          selectedItemColor: Colors.grey,
          onTap: (int index) => {
          setState(() {
            widget._selectedIndex = index;}),}
        ),
      ]);
    });
  }

  getRandomImage() {
    Random random = new Random();
    int num = random.nextInt(6);
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
    } else if (num == 5) {
      return AssetImage('graphics/stossspachtel_1.png');
    } else {
      return AssetImage('400x400_placeholder.png');
    }
  }
}
