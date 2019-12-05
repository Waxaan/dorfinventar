import '_homePage.dart';
import 'package:flutter/material.dart';
import 'customDrawer.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: _categoryWidget(),
    );
  }


  Widget _categoryWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Outdoor"); },
                leading: Icon(Icons.cloud_queue),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Outdoor"),
                ),
                subtitle: Text("Garten, Dienstleistungen und mehr",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Elektronik"); },
                leading: Icon(Icons.computer),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Elektronik"),
                ),
                subtitle: Text("Handys, Computer, größeres...",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Essen"); },
                leading: Icon(Icons.fastfood),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Essen"),
                ),
                subtitle: Text("Selbstgemachtes oder Überschüssiges",),
              ),

            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Gemeinschaft"); },
                leading: Icon(Icons.group_add),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Gemeinschaft"),
                ),
                subtitle: Text("Tickets, Treffen oder Fahrten",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Jobs"); },
                leading: Icon(Icons.work),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Jobs"),
                ),
                subtitle: Text("Ausbildung, Beruf oder Minijob",),
              ),
            ),
            Divider(),
            Container(
              color: Colors.white54,
              child: ListTile(
                onTap:  () { changePage("Zu Verschenken"); },
                leading: Icon(Icons.card_giftcard),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
                  child: Text("Zu Verschenken"),
                ),
                subtitle: Text("Alles, was einen neuen Besitzer sucht",),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePage(pageTitle) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => HomePage(title: pageTitle,)),
    );
  }
}
