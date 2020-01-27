import 'dart:io';

import 'package:Dorfinventar/src/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as prefix0;

import 'httpClient.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final storage = new FlutterSecureStorage();
  Client client = new Client();
  bool loggedIn = false;
  bool get loginStatus => loggedIn;
  List<File> images = new List<File>();
  Map<String, dynamic> categories = new Map<String, dynamic>();
  List<String> categoryList = new List<String>();

  setToken(String _token) async => await storage.write(key: 'token', value: _token);
  setUsername(String _username) async => await storage.write(key: 'username', value: _username);

  getToken() async => await storage.read(key: 'token');
  getUsername() async => await storage.read(key: 'username');


  void resetLastOffer() {
    images = new List<File>();
  }

  getCategoryList() { return categoryList; }
  getCategoryDetail() { return categories; }
  setCategories() async {
    List ret = await client.getCategories();
    var rawCats = ret[0];
    var code = ret[1];
    print("usermodel: setCategories Code: " + code.toString());
    categories = new Map<String, dynamic>();
    categoryList = new List<String>();
    int index = 1;
    for (Map<String, dynamic> cat in rawCats) {
      print("TEST, $index");
      categories[cat['name'] + '_desc'] = cat['description'];
      categories[cat['name'] + '_id'] = index++;
      categoryList.add(cat['name']);
    }
  }

  /// Main Login Function
  /// IF a token was already saved to secure storage, use it
  /// ELSE log-in via the httpClient and the credentials
  login(BuildContext context, {String name, String password}) async{
    var ret = await logMeIn(context, name: name, password: password);
    var statusCode = ret[0];
    var newToken = ret[1];
    print("Model: Logintoken: " + newToken.toString());
    if (statusCode == 200 && newToken != null) {
      loggedIn = true;
      notifyListeners();
      Navigator.pushNamed(context, '/home');
      showSnackbar(context, message: "Login Erfolgreich.");
    }
    if (statusCode == 0) return;
    showSnackbar(context, message: "Login Fehlgeschlagen. Code: " + statusCode.toString());
  }

  Future logMeIn(BuildContext context, {String name, String password}) async {
    print("usermodel: Login with credentials: name: " + name + "   pass: " + password);

    int statusCode = 0;
    var newToken;
    if (name.length < 1) {
      showSnackbar(context, message: "Name muss eingetragen werden.");
      return [statusCode, newToken];
    } else if (password.length < 1) {
      showSnackbar(context, message: "Passwort muss eingetragen werden.");
      return [statusCode, newToken];
    }

    var ret = await client.login(name, password);
    statusCode = ret[0];
    newToken = ret[1];
    if (statusCode == 200 && newToken != null) {
      loggedIn = true;
      notifyListeners();
      setToken(newToken);
      setUsername(name);
      Navigator.popAndPushNamed(context, "/home");
    }
    print("usermodel: Login statuscode: " + statusCode.toString());
    return [statusCode, newToken];
  }



  Future register(BuildContext context, {String name, String email, String pass, String pass2}) async {
    print("usermodel: Register with credentials: name: " + name + " email: " + email + " pass: " + pass + " pass2: " + pass2);
    int statusCode = 404;

    if (name.length < 1) {
      showSnackbar(context, message: "Name muss eingetragen werden.");
      return;
    } else if (email.length < 3) {
      showSnackbar(context, message: "Email muss eingetragen werden.");
      return;
    } else if (pass.length < 1 || pass2.length < 1) {
      showSnackbar(context, message: "Passwort muss eingetragen werden.");
      return;
    } else if (pass != pass2) {
      showSnackbar(context, message: "Passwörter sind nicht identisch.");
      return;
    }

    statusCode = await client.register(name: name, email: email, password: pass);
    print("usermodel: Register statuscode: " + statusCode.toString());
    if (statusCode == 201) {
      login(context, name: name, password: pass);
    } else if (statusCode == 400) {
      showSnackbar(context, message: "Fehler beim Registrieren. Benutzername oder Email bereits vergeben.");
    } else {
      showSnackbar(context, message: "Fehler beim Registrieren. Code: " + statusCode.toString());
    }
  }



  loginFromStorage(BuildContext context) async {
    String token = await getToken();
    print("usermodel: Loaded token from storage: " + token.toString());
    if (token != null) {
      loggedIn = true;
      notifyListeners();
      Navigator.pushNamed(context, '/home');
      showSnackbar(context, message: "Login Erfolgreich.");
      return true;
    }
    Navigator.pushNamed(context, '/login');
    showSnackbar(context, message: "Automatisch Angemeldet.");
    return false;
  }

  logMeOut(BuildContext context) async {
    await storage.delete(key: 'token');
    loggedIn = false;
    notifyListeners();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  postOffer(BuildContext context, {String title, String description, int price, int category, bool available}) async {
    var postBody = new Map<String, dynamic>();
    postBody['name'] = title;
    postBody['desc'] = description;
    postBody['category'] = category;
    postBody['price'] = price;
    postBody['available'] = available;
    print(postBody.toString());
    client.postOfferToServer(modifier: "articles/", postBody: postBody, images: this.images, token: await getToken());
    int index = 0;
    for (File image in images) {
      client.uploadFile(image, index++, await getToken());
    }
  }

  addImage(BuildContext context, File image) {
    if (image != null) this.images.add(image);
    notifyListeners();
  }

  getImagesLength() {
    if (this.images == null) return 0;
    else return this.images.length;
  }

  getImage(int i, double width, double height) {
    if (i == getImagesLength())
      return Center(child: Icon(Icons.photo_camera, size: width/3,));
    else
      return Center(child: Image.file(images[i], width: width, height: height, fit: BoxFit.fitWidth));
  }


  Future getOffers({bool user, String owner, String category, String id, String description, String name, String status}) async {
    var offers;
    int _cat;
    print("USER MODEL: CATEGORY: " + category.toString());
    if(category != null) _cat = categories[category + "_id"];
    print("USER MODEL: CATEGORY ID: " + _cat.toString());

    if (user) offers = await client.getOffersFromServer(await this.getToken(), user: await this.getUsername(), name: name, categoryID: _cat, status: status);
    else offers = await client.getOffersFromServer(this.getToken(), name: name, categoryID: _cat, status: status);
    if (offers.toString() == "[]") {
      List<int> none = [0];
      return none;
    } else
      return offers;
  }

  void sendMessage() {
    client.postMessageToServer();
  }
}
