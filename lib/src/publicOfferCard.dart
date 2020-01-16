import 'package:Dorfinventar/src/_messagesPage.dart';
import 'package:Dorfinventar/src/_offerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublicOfferCard extends Card {
  PublicOfferCard({Key key, this.name, this.description, this.price, this.articleID}) : super(key: key);
  final String name;
  final String description;
  final double price;
  final String articleID;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Center(
        child: GestureDetector(
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OfferPage(title: this.name, description: this.description)))
          },
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
                  subtitle: Text(this.description, overflow: TextOverflow.ellipsis,maxLines: 3,),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Text(getPriceString(this.price))
                    ),
                    /*FlatButton(
                      textColor: Colors.green,
                      child: const Text('Anschauen'),
                      onPressed: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OfferPage(title: this.name, description: this.description)));
                      },
                    ),*/
                    FlatButton(
                      textColor: Colors.green,
                      child: const Text('Nachricht'),
                      onPressed: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MessagesPage(title: "Nachrichten",),));
                      },
                    ),
                  ]
                  ),
               ],
             ),
           ),
        ),
      ),
    );
  }
}


String getPriceString(double price) {
  if(price == 0)
    return "Gratis";
  return price.toStringAsFixed(2) + "€";
}
