import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool loggedIn = false;

  bool get loginStatus=> loggedIn;

  void login() {
    // First, increment the counter
    loggedIn = true;
    // Then notify all the listeners.
    notifyListeners();
  }
}