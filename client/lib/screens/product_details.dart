import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              product['name'],
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  alignment: Alignment.center,
                  child: Image.network(product['imagem'])),
              Text(product['nome'], style: const TextStyle(fontSize: 24.0)),
              Text(product['preco'], style: const TextStyle(fontSize: 18.0)),
              Text(product['descricao'], style: const TextStyle(fontSize: 16.0))
            ]),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () {
              print(product['id']);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(70.0),
                backgroundColor: Colors.deepPurple,
                elevation: 0),
            child: const Text('Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 18.0))));
  }
}
