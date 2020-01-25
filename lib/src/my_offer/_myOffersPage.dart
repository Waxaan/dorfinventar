import 'package:Dorfinventar/src/my_offer/privateOfferCard.dart';
import 'package:Dorfinventar/src/userModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dorfinventar/src/my_offer/_newOfferPage.dart';
import 'package:Dorfinventar/src/customDrawer.dart';
import 'dart:math';

class MyOffersPage extends StatefulWidget {
  MyOffersPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyOffersPage createState() => _MyOffersPage();
}

class _MyOffersPage extends State<MyOffersPage> {
  List<Widget> items = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: CustomDrawer(),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              return Column(
                  children: [
                    getListOfOffers(model),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/newOffer");
                          model.resetLastOffer();
                        },
                        child: Card(
                            color: Colors.green,
                            child: ListTile(
                              title: Center(
                                  child: Text("+",
                                    style: TextStyle(fontSize: 48),
                                  )
                              ),
                            )
                        )
                    )
                  ]
              );
            }
        )
    );
  }

  addNewOffer() {
    setState(() {
      items.add(getNewOffer());
    });
  }

  showSnackbar(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Inserat wurde hinzugefügt")));
  }

  PrivateOfferCard getNewOffer() {
    Random random = new Random();
    List<PrivateOfferCard> items = <PrivateOfferCard>[];
    items.add(PrivateOfferCard(
        name: "TODO: Günstiges Produkt",
        description: "TODO: Sample Beschreibung",
        price: random.nextDouble() * 10));
    items.add(PrivateOfferCard(
        name: "TODO: Normales Produkt",
        description: "TODO: Sample Beschreibung",
        price: 5 + random.nextDouble() * 50));
    items.add(PrivateOfferCard(
        name: "TODO: Luxus Produktname",
        description: "TODO: Sample Beschreibung",
        price: 50 + random.nextDouble() * 200));
    return items[random.nextInt(3)];
  }


  getListOfOffers(UserModel model) {
    List<Widget> offers = model.getMyOffers();
    if (offers == null) {
      return Container(width: 0, height: 0);
    }
    return Expanded(
        child: ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return offers[index];
          },
        )
    );
  }
}
