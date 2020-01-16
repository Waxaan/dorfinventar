import 'package:Dorfinventar/src/privateOfferCard.dart';
import 'package:Dorfinventar/src/userModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dorfinventar/src/_newOfferPage.dart';
import 'customDrawer.dart';
import 'dart:math';

class MyOffersPage extends StatefulWidget {
  MyOffersPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyOffersPage createState() => _MyOffersPage();
}

class _MyOffersPage extends State<MyOffersPage> {
  @override
  List<Widget> items = new List<Widget>();
  void initState() {
    super.initState();
    items = getPrivateOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: _settingsWidget(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Text("+", style: TextStyle(fontSize: 32)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewOfferPage(title: "Neues Angebot")));

            showSnackbar(context);
          },
          ),
        ),
    );
  }


  Widget _settingsWidget() {
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }

  addNewOffer() {
    setState(() {
      items.add(getNewOffer());
    });
  }

  showSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Inserat wurde hinzugefügt")));
  }

  PrivateOfferCard getNewOffer() {
    Random random = new Random();
    List<PrivateOfferCard> items = <PrivateOfferCard>[];
    items.add(PrivateOfferCard(
      name: "TODO: Günstiges Produkt", description: "TODO: Sample Beschreibung", price: random.nextDouble()*10));
    items.add(PrivateOfferCard(
      name: "TODO: Normales Produkt", description: "TODO: Sample Beschreibung", price: 5+random.nextDouble()*50));
    items.add(PrivateOfferCard(
      name: "TODO: Luxus Produktname", description: "TODO: Sample Beschreibung", price: 50+random.nextDouble()*200));
    return items[random.nextInt(3)];
  }

  List<Widget> getPrivateOffers() {
    List<Widget> items = new List<Widget>();
    return items;
  }
}
