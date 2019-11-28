import 'package:flutter/material.dart';

class MessageCard extends Card {
  MessageCard({Key key, this.userIconID, this.username, this.preview, this.age}) : super(key: key);
  final String userIconID;
  final String username;
  final String preview;
  final double age;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Center(
        child: Card(
          elevation: 3.0,
          color: Colors.white54,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {},
                trailing: Icon(Icons.reply),
                leading: Icon(getUserIcon(userIconID)),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Text(this.username),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(getAge(this.age), overflow: TextOverflow.clip,),
                    ),
                    Flexible(
                      child: Container(
                        padding: new EdgeInsets.fromLTRB(12, 6, 6, 6),
                        child: Text(this.preview, overflow: TextOverflow.ellipsis,maxLines: 2,),
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getUserIcon(String userIconID) {
    return Icons.insert_emoticon;
  }

  String getAge(double timeInMinutes) {
    if(timeInMinutes < 2)
      return "Neu";
    if(timeInMinutes < 60)
      return timeInMinutes.toStringAsFixed(0) + "min";
    if(timeInMinutes < 1440)
      return (timeInMinutes/60.0).toStringAsFixed(0) + "h";
    return (timeInMinutes/1440.0).toStringAsFixed(0) + "d";
  }
}
