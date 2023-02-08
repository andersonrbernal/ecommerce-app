import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ProductProvider {
  final String _providerAPI = dotenv.get('PROVIDER_API');
  static final String _server = dotenv.get('SERVER_API');
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<List<dynamic>> getProducts() async {
    Uri uri = Uri.parse(_providerAPI);
    try {
      Response response = await get(uri, headers: _headers);
      List<dynamic> products = await jsonDecode(response.body);
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getProductsThatAreNotInCart(String userId) async {
    Uri uri = Uri.parse("$_server/products/$userId");
    try {
      Response response = await get(uri, headers: _headers);
      Map<String, dynamic> data = await jsonDecode(response.body);
      return data['data'] as List;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> findProduct(String index) async {
    Uri uri = Uri.parse("$_providerAPI/$index");

    try {
      Response response = await get(uri, headers: _headers);
      List<dynamic> product = await jsonDecode(response.body);
      return product;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> searchProducts(String value) async {
    List<dynamic> products;
    List<dynamic> matchQuery = [];

    try {
      products = await getProducts();
      matchQuery = products.where((product) {
        bool productOnlyIfItStartWithTheTypedValue = product['nome']
            .toString()
            .toLowerCase()
            .startsWith(value.toLowerCase());

        return productOnlyIfItStartWithTheTypedValue;
      }).toList();
    } catch (e) {
      rethrow;
    }
    return matchQuery;
  }
}
