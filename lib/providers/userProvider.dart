import 'package:auth/models/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List<User> userList = [];
  addUser(String user, var age) async {
    User users = User(user, age);
    userList.add(users);
    notifyListeners();
  }

  removeUser(User user) async {
    userList.remove(user);
    notifyListeners();
  }
}
