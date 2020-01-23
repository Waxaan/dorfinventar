import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  bool loggedIn = false;
  bool get loginStatus=> loggedIn;

  Future login({String name, String password}) async {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.get(url);

    int statusCode = response.statusCode;
    //print(statusCode);
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    //print(json);

    print("name: " + name + "   pass: " + password);
    if (name.length > 1 &&  password.length > 1) {
      loggedIn = true;
      notifyListeners();
    } else {
      loggedIn = false;
      notifyListeners();
    }

    if (loggedIn) {
      return 0;
    } else {
      return 1;
    }
  }

  Future register({String name, String email, String pass, String pass2}) async {
    print("name: " + name + " email: " + email + " pass: " + pass + " pass2: " + pass2);

    if (name.length > 1 &&  email.length > 1 && pass.length > 1 && pass == pass2) {
      return 0;
    } else {
      return 1;
    }
  }
}
