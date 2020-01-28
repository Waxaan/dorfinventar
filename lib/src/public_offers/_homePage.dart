import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
import '../userModel.dart';
import 'publicOfferCard.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title, this.loggedIn}) : super(key: key);
  final String title;
  final bool loggedIn;
  int index = 0;
  String searchBody;
  Future<List<PublicOfferCard>> offers;
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  _updateSearch(context, query) {
    print(query);
    setState(() {
      widget.searchBody = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(
            onQueryChanged: (query) => _updateSearch(context, query),
            onQuerySubmitted: (query) => _updateSearch(context, query),
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
            future: model.getOffers(user: false, category: widget.title, name: widget.searchBody),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data[index] == 0) {
                            return ListTile(
                              title: Text("Leider ist kein Angebot in dieser Kategorie verfügbar"),
                            );
                          }
                        return PublicOfferCard(
                          price: snapshot.data[index]['price'],
                          name: snapshot.data[index]['name'],
                          category: snapshot.data[index]['category_name'],
                          description: snapshot.data[index]['description'],
                          owner: snapshot.data[index]['owner'],
                          articleID: snapshot.data[index]['id'],
                          isActive: snapshot.data[index]['status'],
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
}
