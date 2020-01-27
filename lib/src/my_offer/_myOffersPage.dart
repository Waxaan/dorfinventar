import 'package:Dorfinventar/src/my_offer/privateOfferCard.dart';
import 'package:Dorfinventar/src/public_offers/publicOfferCard.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: CustomDrawer(),
        body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Column(children: [
            FutureBuilder(
                future: model.getOffers(user: true),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return PublicOfferCard(
                                price: snapshot.data[index]['price'],
                                name: snapshot.data[index]['name'],
                                description: snapshot.data[index]['description'],
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
                }),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/newOffer");
                  model.resetLastOffer();
                },
                child: Card(
                    color: Colors.green,
                    child: ListTile(
                      title: Center(
                          child: Text(
                        "+",
                        style: TextStyle(fontSize: 48),
                      )),
                    )))
          ]);
        }));
  }
}
