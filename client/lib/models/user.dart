import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class User with ChangeNotifier {
  late String _token;

  User(this._token);

  String get token => _token;

  set token(String token) {
    _token = token;
    notifyListeners();
  }

  String get id {
    Map<String, dynamic> jwt = JwtDecoder.decode(_token);
    return jwt['id'];
  }

  String get username {
    Map<String, dynamic> jwt = JwtDecoder.decode(_token);
    return jwt['username'];
  }

  String get email {
    Map<String, dynamic> jwt = JwtDecoder.decode(_token);
    return jwt['email'];
  }
}
