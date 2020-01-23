import 'package:Dorfinventar/src/userModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Dorfinventar/src/helpers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*  Login Page
      Nur die Login-Seite der App
      Zeigt dem User eine Seite mit Login, Passwort und einer Möglichkeit sich
      neu zu registrieren

 */

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.loggedIn}) : super(key: key);
  final String title;
  bool loggedIn;


  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final myControllerName = TextEditingController();
  final myControllerPass = TextEditingController();

  /*_init() async{

    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'token');

    if (token != null){
      Navigator.pushNamed(context, '/home');
    }

  }

  @override
  void initState(){
    super.initState();
    _init();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loginWidget(myControllerName, myControllerPass),
    );

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerName.dispose();
    myControllerPass.dispose();
    super.dispose();
  }


  Widget _loginWidget(TextEditingController myControllerName, TextEditingController myControllerPass) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
          return Column(
            children: <Widget>[
              TextFormField(
                controller: myControllerName,
                decoration: InputDecoration(
                    labelText: "Benutzername"
                ),),
              TextFormField( obscureText: true,
                controller: myControllerPass,
                decoration: InputDecoration(
                    labelText: "Passwort"
                ),),
              RaisedButton(
                onPressed: () async {
                  int loginCode = await model.login(name: myControllerName.text,
                                                    password: myControllerPass.text);
                  if (loginCode == 200) { // successful
                    Navigator.popAndPushNamed(context, "/home");
                  } else if (loginCode == 1) {
                    showSnackbar(context, message: "Eins oder mehrere Textfelder leer");
                  } else if (loginCode == 2) {
                    showSnackbar(context, message: "Invalide Logindaten");
                  }
                },
                  child: Text("Login"),
              ),
              Text("Besitzen Sie noch keinen Account?"),
              RaisedButton(
                  onPressed: () => Navigator.pushNamed(context, "/register"),
                  child: Text("Registrieren"),
              ),
            ],
          ); }
          )
      )
    );
  }
}