import 'package:Dorfinventar/src/helpers.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../customDrawer.dart';
import '../userModel.dart';


/*  Register Page
      Zeigt dem User eine Seite mit Login, Passwort und anderen Einstellungen,
      die zu beginn gesetzt werden können.

 */

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final myControllerName = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPass = TextEditingController();
  final myControllerPass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _settingsWidget(myControllerName, myControllerEmail, myControllerPass, myControllerPass2),
    );
  }



  Widget _settingsWidget(TextEditingController myControllerName, TextEditingController myControllerEmail,
                         TextEditingController myControllerPass, TextEditingController myControllerPass2) {
    return Center(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Padding(
            padding: EdgeInsets.all(24.0),
            child: ListView(
              children: <Widget>[
                Text("Vielen Dank für Ihre Entscheidung sich bei uns zu registrieren"),
                TextFormField(
                  controller: myControllerName,
                  decoration: InputDecoration(
                    labelText: "Benutzername"
                ),),
                TextFormField(
                  controller: myControllerEmail,
                  decoration: InputDecoration(
                    labelText: "E-Mail"
                ),),
                TextFormField( obscureText: true,
                  controller: myControllerPass,
                  decoration: InputDecoration(
                      labelText: "Passwort"
                  ),),
                TextFormField( obscureText: true,
                  controller: myControllerPass2,
                  decoration: InputDecoration(
                      labelText: "Passwort bestätigen"
                  ),),
                RaisedButton(
                   onPressed: () async => model.register(context, name: myControllerName.text, email: myControllerEmail.text,
                                                                  pass: myControllerPass.text, pass2: myControllerPass2.text),
                   child: Text("Registrieren"),
                ),
            ],
          ),
        );
        }
      )
    );
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerName.dispose();
    myControllerPass.dispose();
    super.dispose();
  }
}
