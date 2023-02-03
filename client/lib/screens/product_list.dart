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
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      products = await getProducts();
    });
  }

  Future<List<dynamic>> getProducts() async {
    try {
      Uri uri = Uri.parse(dotenv.get('PROVIDER_API'));
      Response response = await get(uri);
      return products = await jsonDecode(response.body);
    } catch (e) {
      print(e);
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
            child: GridView.builder(
                itemCount: products.isNotEmpty ? products.length : 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => ProductCard(
                    name: products[index]['nome'],
                    picture: products[index]['imagem'],
                    price: products[index]['preco'])),
          )
        ])));
  }
}
