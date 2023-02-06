import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Auth {
  static final String _server = dotenv.get('SERVER_API');

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    String url = '$_server/auth/login';

    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    Response response = await post(Uri.parse(url),
        headers: _headers, body: jsonEncode(requestBody));
    Map<String, dynamic> data = await jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> signup(
    String username,
    String email,
    String password,
  ) async {
    String url = '$_server/auth/register';

    Map<String, String> requestBody = {
      'email': email,
      'password': password,
      'username': username
    };

    Response response = await post(Uri.parse(url),
        headers: _headers, body: jsonEncode(requestBody));
    Map<String, dynamic> data = await jsonDecode(response.body);

    return data;
  }
}
