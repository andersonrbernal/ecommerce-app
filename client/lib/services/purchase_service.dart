import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class PurchaseService {
  static final String _server = '${dotenv.get('SERVER_API')}/purchase';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> getUserPurchases(String userId) async {
    Uri uri = Uri.parse("$_server/$userId");

    try {
      Response response = await get(uri, headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> registerPurchase(String userId) async {
    Uri uri = Uri.parse('$_server/register/$userId');

    try {
      Response response = await post(uri, headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
