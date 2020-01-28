import 'package:Dorfinventar/src/messaging/_messagesPage.dart';
import 'package:Dorfinventar/src/public_offers/_offerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../userModel.dart';

class PublicOfferCard extends Card {


  PublicOfferCard(
      {Key key, this.name, this.description, this.price, this.articleID, this.owner, this.isActive, this.category, this.loggedIn})
      : super(key: key);
  final String name;
  final String description;
  final int price;
  final int articleID;
  final String owner;
  final String isActive;
  final String category;
  final bool loggedIn;


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Center(
          child: GestureDetector(
            onTap: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        OfferPage(title: this.name,
                            category: this.category,
                            description: this.description,
                            articleID: this.articleID,
                            owner: this.owner,
                            price: getPriceString(this.price),
                            isActive: this.isActive,

                            ))),
            child: Card(
              color: Colors.white54,
              elevation: 3,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_enhance),
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                      child: Text(this.name),
                    ),
                    subtitle: Text(
                      this.description, overflow: TextOverflow.ellipsis,
                      maxLines: 3,),
                  ),
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Text(getPriceString(this.price))
                        ),
                        this.loggedIn? FlatButton(
                          textColor: Colors.green,
                          child: const Text('Nachricht'),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    MessagesPage(title: "Nachrichten",),));
                          },
                        )
                            :
                        Container(width: 0, height: 0,),
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }


  String getPriceString(int price) {
    if (price == 0)
      return "Gratis";
    return (price.toDouble()/10000).toStringAsFixed(2) + "€";
  }
}
