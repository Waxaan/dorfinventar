import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Client {

  final storage = new FlutterSecureStorage();
  var token;

  setToken(String _token) async {
    await storage.write(key: 'token', value: _token);
  }


  getToken() async {
    return await storage.read(key: 'token');
  }


  Future login(String name, String password) async {
    print("ASDASD");
    print(getToken());
    token = await getToken();
    print(token);
    var postBody = new Map<String, dynamic>();
    postBody['username'] = name;
    postBody['password'] = password;
    
    var ret= await postToServer(postBody: postBody, modifier: "auth/login");
    var body = ret[0];
    var code = ret[1];

    String temp = "JWT " + body['access_token'].toString();
    setToken(temp);
    
    return code;

  }
  Future register({String name, String email, String password}) async {
    var postBody = new Map<String, dynamic>();
    postBody['username'] = name;
    postBody['email'] = email;
    postBody['password'] = password;

    var ret = await postToServer(postBody: postBody, modifier: "auth/register");
    var body = ret[0];
    var code = ret[1];

    return code;

  }



  Future postToServer({Map<String, dynamic> postBody, String modifier}) async {
    String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + modifier;
    var jsonBody = convert.json.encode(postBody);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody
    );

    int statusCode = response.statusCode;

    return [convert.jsonDecode(response.body), statusCode];
  }

}