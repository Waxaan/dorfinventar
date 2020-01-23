import 'package:flutter/material.dart';

class MessageTile extends ListTile {

  MessageTile({Key key, this.content, this.isuser}) : super(key: key);
  final String content;
  final bool isuser;


  @override
  Widget build(BuildContext context) {
    if(this.isuser) {
      return Padding(
        padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(left: 40),
            child: Card(
              color: Colors.green,
              child: ListTile(
                subtitle: Text(this.content, overflow: TextOverflow.ellipsis,maxLines: 10,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.25)),
               ),
             )
           )
        )
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: Card(
              child: ListTile(
                subtitle: Text(this.content, overflow: TextOverflow.ellipsis,maxLines: 10,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.25)),
              ),
            )
          )
        )
      );
    }
  }
}
