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

  String _name = "",
      _email = "namanrajani16@gmail.com",
      _contact = "",
      _password = "",
      _id = "";
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'email': _email,
      'contact': _contact,
    };
  }

  String get getEmail {
    return _email;
  }

  String get getName {
    return _name;
  }

  String get getPassword {
    return _password;
  }

  String get getContact {
    return _contact;
  }

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set setStudentId(String id) {
    _id = id;
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
