import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class Client {
  Future login(String name, String password) async {
    var postBody = new Map<String, dynamic>();
    postBody['username'] = name;
    postBody['password'] = password;
    
    var ret = await postToServer(postBody: postBody, modifier: "auth/login");
    var body = ret[0];
    var code = ret[1];

    String newToken = "JWT " + body['access_token'].toString();
    
    return [code, newToken];

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