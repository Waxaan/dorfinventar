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
    print(response.body);
    print(statusCode);
    /*File image = images[0];
    var request = http.MultipartRequest("POST", Uri.parse(url));
    //request.fields["text_field"] = text;
    var pic = await http.MultipartFile.fromPath("file_field", image.path);

    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    int statusCode = response.statusCode; */
    return [convert.jsonDecode(response.body), statusCode];
  }

  uploadFile(File image, int i) async {
    print("httpClient: Uploading image $i");
    var postUri = Uri.parse("http://mobint-projekt.hci.uni-hannover.de/api/" + "images/$i");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
      request.files.add(
          new http.MultipartFile.fromBytes('file',
              await File.fromUri(image.uri).readAsBytes(),
              contentType: MediaType('image', 'jpeg')));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
      print(response.statusCode);
      print(response.toString());
    });
  }

  Future getMyOffersFromServer(token) async {
   /* var postBody = new Map<String, dynamic>();
    var ret = await postAuthToServer(postBody: postBody, modifier: "auth/register");
    var body = ret[0];
    var code = ret[1];

    return code;
 */
  }


 /* Future postAuthToServer({Map<String, dynamic> postBody, String modifier}) async {
    String url = 'http://mobint-projekt.hci.uni-hannover.de/api/' + modifier;
    var jsonBody = convert.json.encode(postBody);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody
    );

    int statusCode = response.statusCode;
    return [convert.jsonDecode(response.body), statusCode];

  } */

}