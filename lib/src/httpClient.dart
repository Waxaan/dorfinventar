import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class Client {
  Future login(String name, String password) async {
    var postBody = new Map<String, dynamic>();
    postBody['username'] = name;
    postBody['password'] = password;
    
    var ret = await postAuthToServer(postBody: postBody, modifier: "auth/login");
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

    var ret = await postAuthToServer(postBody: postBody, modifier: "auth/register");
    var body = ret[0];
    var code = ret[1];

    return code;

  }


  Future postAuthToServer({Map<String, dynamic> postBody, String modifier}) async {
    String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + modifier;
    var jsonBody = convert.json.encode(postBody);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody
    );

    int statusCode = response.statusCode;
    return [convert.jsonDecode(response.body), statusCode];
  }


  Future postOfferToServer({Map<String, dynamic> postBody, String token, String modifier, List<File> images}) async {
    String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + modifier;
    var jsonBody = convert.json.encode(postBody);

    print("httpClient: Posting to $url");
    print(jsonBody);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json",
                  "Authorization": token.toString()},
        body: jsonBody
    );
    int statusCode = response.statusCode;
    print("httpClient: postOffer responsebody: " + response.body.toString());
    print(statusCode);
    return [convert.jsonDecode(response.body), statusCode];
  }

  uploadFile(File image, int articleID, String token) async {
    print("httpClient: Uploading image $articleID");
    var postUri = Uri.parse("http://mobint-projekt.hci.uni-hannover.de/api/" + "images/" + articleID.toString());
    var request = new http.MultipartRequest("POST", postUri);
    request.headers.addAll({"Content-Type": "application/json",
                            "Authorization": token.toString()});
    request.fields['user'] = token.toString();
      request.files.add(
          new http.MultipartFile.fromBytes('file',
              await File.fromUri(image.uri).readAsBytes(),
              contentType: MediaType('image', 'jpeg')));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
      print("Fileupload: Statuscode: " + response.statusCode.toString());
      print("Filupload Response: " + response.headers.toString());
    });
  }

  Future getOffersFromServer(token, {String user, String category, String name, String status}) async {
    String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + "articles/";

    Map<String, dynamic> header = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    header['Authorization'] = token.toString();
    String args = "";
    if (user != null) args += "owner=$user&";
    if (name != null) args += "name=$name&";
    if (category != null) args += "category=$category&";
    if (status != null) args += "status=$status";
    url = url + args;
    print("httpClient: getOffersFromServer: Posting to $url");
    var response = await http.get(url + args, headers:
      {"Content-Type": "application/json",
      "Authorization": token.toString(),
    });
    int statusCode = response.statusCode;
    print("httpClient: getOffersFromServer: Code: " + statusCode.toString());

    return convert.jsonDecode(response.body);
  }

  Future postMessageToServer({Map<String, dynamic> postBody, String token, String modifier, List<File> images}) async {
    /*String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + "chat/messages/";
    var postBody = new Map<String, dynamic>();
    postBody['message'] = name;
    postBody['subject'] = email;
    postBody['username'] = "";
    postBody['user2'] =
    var jsonBody = convert.json.encode(postBody);

    print("httpClient: Posting to $url");
    print(jsonBody);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json",
          "Authorization": token.toString()},
        body: jsonBody
    );
    int statusCode = response.statusCode;
    print(response.body);
    print(statusCode);
    return [convert.jsonDecode(response.body), statusCode]; */
  }
}