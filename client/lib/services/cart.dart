import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Cart {
  static final String _server = '${dotenv.get('SERVER_API')}/cart';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  late String userId;

  Cart({required this.userId});

  Future<List<dynamic>> getCart() async {
    String url = '$_server/$userId';

    try {
      Response response = await get(Uri.parse(url), headers: _headers);
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> updateCart(List<dynamic> items) async {
    String requestBody = jsonEncode(items);
    String url = '$_server/$userId';

    try {
      Response response =
          await put(Uri.parse(url), headers: _headers, body: requestBody);
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteCart() async {
    String url = '$_server/$userId';

    try {
      Response response = await delete(Uri.parse(url), headers: _headers);
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
