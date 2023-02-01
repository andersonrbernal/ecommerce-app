import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Auth {
  late String endpoint;
  late Map<String, String> requestBody;

  final String _server = dotenv.get('SERVER_API');

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Auth({required this.endpoint, required this.requestBody});

  Future<Response> login() async {
    String url = '$_server/$endpoint';

    Response response = await post(Uri.parse(url),
        headers: _headers, body: jsonEncode(requestBody));
    return response;
  }

  Future<Response> signup() async {
    String url = '$_server/$endpoint';
    Response response = await post(Uri.parse(url),
        headers: _headers, body: jsonEncode(requestBody));
    return response;
  }
}
