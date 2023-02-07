import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class CartService {
  static final String _server = '${dotenv.get('SERVER_API')}/cart';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  late final String _userId;

  CartService(this._userId);

  Future<Map<String, dynamic>> getCart() async {
    String url = "$_server/$_userId";

    try {
      Response response = await get(Uri.parse(url), headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getCartProducts() async {
    String url = '$_server/products/$_userId';

    try {
      Response response = await get(Uri.parse(url), headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> updateCart(List<dynamic> items) async {
    String requestBody = jsonEncode(items);
    String url = '$_server/$_userId';

    try {
      Response response =
          await put(Uri.parse(url), headers: _headers, body: requestBody);
      List<dynamic> data = await jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteCart() async {
    String url = '$_server/$_userId';

    try {
      Response response = await delete(Uri.parse(url), headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeProduct(int id) async {
    String requestBody = jsonEncode({'productId': id});
    String url = '$_server/$_userId';

    try {
      Response response = await put(
        Uri.parse(url),
        headers: _headers,
        body: requestBody,
      );
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data['success'];
    } catch (e) {
      rethrow;
    }
  }
}
