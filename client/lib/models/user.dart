import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  late String _token;

  User(this._token);

  String get token => _token;

  set token(String token) {
    _token = token;
    notifyListeners();
  }
}
