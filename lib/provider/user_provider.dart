import 'package:flutter/cupertino.dart';

class Users {
  String name = "", email = "", contact = "", password = "";
  Users(
      {required this.name,
      required this.email,
      required this.contact,
      required this.password});
}

class UserProvider with ChangeNotifier {
  final List<Users> _users = [];

  String _name = "", _email = "", _contact = "", _password = "";
  String get getEmail {
    return _email;
  }

  String get getPassword {
    return _password;
  }

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set setContact(String name) {
    _contact = name;
    notifyListeners();
  }

  set setName(String name) {
    _name = name;
    notifyListeners();
  }

  set setPassword(String name) {
    _password = name;
    notifyListeners();
  }

  List<Users> get users {
    return [..._users];
  }

  void addUsers(Users u) {
    _users.add(u);
    notifyListeners();
  }
}
