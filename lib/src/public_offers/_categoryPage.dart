import 'package:loader_search_bar/loader_search_bar.dart';

import 'package:Dorfinventar/src/public_offers/_homePage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../userModel.dart';

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
      appBar: SearchBar(
          defaultBar: AppBar(
            title: Text(widget.title),
      )),
      body: _categoryWidget(),
    );
  }

  Widget _categoryWidget() {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Center(
          child: ListView.separated(
              itemCount: model.getCategoryList().length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return categoryTileBuilder(
                    model.getCategoryList()[index], model.getCategoryDetail());
              }));
    });
  }

  void changePage(category) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(title: category)),
    );
  }

  categoryTileBuilder(String category, Map<String, dynamic> categoryDetail) {
    var icons = {
      "Outdoor": Icons.cloud_queue,
      "Elektronik": Icons.computer,
      "Essen": Icons.fastfood,
      "Gemeinschaft": Icons.group_add,
      "Jobs": Icons.work,
      "Zu Verschenken": Icons.card_giftcard
    };

    return Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Container(
          color: Colors.white54,
          child: ListTile(
            onTap: () => changePage(category),
            leading:
                Icon(icons[category] != null ? icons[category] : Icons.warning),
            title: Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 3),
              child: Text(category),
            ),
            subtitle: Text(categoryDetail[category + '_desc']),
          ),
        ));
  }
}
