import 'httpClient.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool loggedIn = false;
  bool get loginStatus => loggedIn;


  Client client = new Client();


  LogMeIn() async{
    String token = await client.getToken();

    if (token != null){
      loggedIn = true;
      notifyListeners();
      //Navigator.pushNamed(context, '/home');
    }

  }

  Future login({String name, String password}) async {
    print("name: " + name + "   pass: " + password);

    int statusCode = 404;
    if (name.length > 1 && password.length > 1) {
      statusCode = await client.login(name, password);
      if (statusCode == 200) {
        loggedIn = true;
        notifyListeners();
      }
    }
    return statusCode;
  }

  Future register({String name, String email, String pass, String pass2}) async {
    print("name: " + name + " email: " + email + " pass: " + pass + " pass2: " + pass2);
    int statusCode = 404;

    if (name.length > 1 &&  email.length > 1 && pass.length > 1 && pass == pass2) {
      int statusCode = await client.register(name: name, email: email, password: pass);
      if (statusCode == 201) {
        int loginCode = await login(name: name, password: pass);
        return loginCode;
      }
    }
    return statusCode;
  }
}
