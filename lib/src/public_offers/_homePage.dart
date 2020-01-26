import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
import '../userModel.dart';
import 'publicOfferCard.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.loggedIn}) : super(key: key);
  final String title;
  final bool loggedIn;
  Future<List<PublicOfferCard>> offers;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
            defaultBar: AppBar(
              title: Text(widget.title),
        )),
        drawer: CustomDrawer(),
        body: _homeWidget());
  }

  Widget _homeWidget() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Column(children: [
        ListTile(
          leading: Icon(Icons.loyalty),
          title: Text("Neuste Angebote"),
        ),
        FutureBuilder(
            future: model.getOffers(user: true),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data[index]);
                          return PublicOfferCard(
                            price: snapshot.data[index]['price'],
                            name: snapshot.data[index]['name'],
                            description: snapshot.data[index]['description'],
                            ownerID: snapshot.data[index]['owner'],
                            articleID: snapshot.data[index]['id'],
                          );
                        }));
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 100,
                        height: 100,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ]);
              }
            })
      ]);
    });
  }


  List<Widget> getNewOffers() {
    List<Widget> items = new List<Widget>();
    items.add(PublicOfferCard(
      name: "Gartenschere",
      description: "So gut wie neu",
      price: 3000,
    ));
    items.add(PublicOfferCard(
      name: "Baum fällen",
      description: "Ich untersütze sie beim Fällen eines Baumes, "
          "Preis bitte per Nachricht",
      price: 0,
    ));
    items.add(PublicOfferCard(
      name: "Omas Käsekuchen",
      description: "Der beste im ganzen Dorf",
      price: 1000,
    ));
    return items;
  }

  List<Widget> getInterestingOffers() {
    List<Widget> items = new List<Widget>();
    items.add(PublicOfferCard(
      name: "Mediteraner Kochkurs",
      description:
          "Bitte über Nachricht anmelden und Lebensmittel selbst mirnehmen.",
      price: 100,
    ));
    items.add(
      PublicOfferCard(
        name: "Vergaserinnenbeleuchtung",
        description: "Weitere Produkte im Sortiment: "
            "Getriebesand, Kolbenrückholfedern, Keilriemenfett",
        price: 2500,
      ),
    );
    items.add(
      PublicOfferCard(
        name: "Kindergeburtstag",
        description:
            "Wir richten für Ihr Kind einen unvergesslichen Geburtstag aus!",
        price: 1000,
      ),
    );
    items.add(
      PublicOfferCard(
        name: "Klausurlöung Elektrotechnik",
        description: "Für die Informatiker, "
            "die einfach nicht wollen",
        price: 10000,
      ),
    );
    items.add(
      PublicOfferCard(
          name: "Spachtel", description: "Noch fast unbenutzt", price: 6000),
    );
    return items;
  }
}
