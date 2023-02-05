import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Provider {
  final String _providerAPI = dotenv.get('PROVIDER_API');

  Future<List<dynamic>> getProducts() async {
    try {
      Uri uri = Uri.parse(_providerAPI);
      Response response = await get(uri);
      List<dynamic> products = await jsonDecode(response.body);
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> findProduct(String index) async {
    Uri uri = Uri.parse("$_providerAPI/$index");
    try {
      Response response = await get(uri);
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
