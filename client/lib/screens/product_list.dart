import 'dart:convert';
import 'package:client/widgets/product_card.dart';
import 'package:client/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController? _textController;

  Future<List<dynamic>> loadProducts() async {
    try {
      Uri uri = Uri.parse(dotenv.get('PROVIDER_API'));
      Response response = await get(uri);
      List<dynamic> data = await jsonDecode(response.body);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: Column(children: [
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: const Text('Awesome Shop',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))),
          SearchBar(textController: _textController),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: loadProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      List<dynamic> products = snapshot.data!;

                      return GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) => ProductCard(
                              name: products[index]['nome'],
                              picture: products[index]['imagem'],
                              price: products[index]['preco']));
                    }

                    return const Center(
                        child: Text('Ooops, something went wrong.'));
                  }))
        ])));
  }
}
