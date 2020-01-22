import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import '../customDrawer.dart';
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
        )
      ),
      drawer: CustomDrawer(),
      body: _homeWidget()
    );
  }


  Widget _homeWidget() {
    List<Widget> items = getWidgets();
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }

  List<Widget> getWidgets() {
    List<Widget> items = new List<Widget>();
    items.add(
        ListTile(
          leading: Icon(Icons.loyalty),
          title: Text("Neuste Angebote"),
        ));
    items.addAll(getNewOffers());
    items.add(Divider());
    items.add(
        ListTile(
          leading: Icon(Icons.local_offer),
          title: Text("Interessante Angebote"),
        ));
    items.addAll(getInterestingOffers());

    return items;
    }
  // https://flutter.dev/docs/cookbook/networking/fetch-data
  List<Widget> getOnlineOffers() {
    List<Widget> items = new List<Widget>();
    Future<http.Response> fetchPost() {
      return http.get('https://jsonplaceholder.typicode.com/posts/1');
    }
  }

  List<Widget> getNewOffers() {
    List<Widget> items = new List<Widget>();
    items.add(PublicOfferCard(
      name: "Gartenschere", description: "So gut wie neu", price: 30.0,));
    items.add(PublicOfferCard(
      name: "Baum fällen", description: "Ich untersütze sie beim Fällen eines Baumes, "
        "Preis bitte per Nachricht", price: 0,));
    items.add(PublicOfferCard(
      name: "Omas Käsekuchen", description: "Der beste im ganzen Dorf", price: 10.0,));
    return items;
  }

  List<Widget> getInterestingOffers() {
    List<Widget> items = new List<Widget>();
    items.add(PublicOfferCard(name: "Mediteraner Kochkurs",
      description: "Bitte über Nachricht anmelden und Lebensmittel selbst mirnehmen.",
      price: 1.0,));
    items.add(PublicOfferCard(name: "Vergaserinnenbeleuchtung", description: "Weitere Produkte im Sortiment: "
        "Getriebesand, Kolbenrückholfedern, Keilriemenfett", price: 25.0,),);
    items.add(PublicOfferCard(name: "Kindergeburtstag", description: "Wir richten für Ihr Kind einen unvergesslichen Geburtstag aus!", price: 10.0,),);
    items.add(PublicOfferCard(name: "Klausurlöung Elektrotechnik", description: "Für die Informatiker, "
        "die einfach nicht wollen", price: 100.0,),);
    items.add(PublicOfferCard(name: "Spachtel", description: "Noch fast unbenutzt", price: 6.00),);
    return items;
  }
}
