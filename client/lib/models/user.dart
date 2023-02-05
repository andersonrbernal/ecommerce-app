import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class User extends ChangeNotifier {
  String token;

  User(this.token);

  String get() {
    return token;
  }

  update(String token) {
    this.token = token;
  }

  String getUserId() {
    Map<String, dynamic> userId = JwtDecoder.decode(token);
    return userId['id'];
  }
}
