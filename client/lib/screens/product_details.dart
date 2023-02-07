import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Map<String, dynamic> product;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.product['nome'],
              style: const TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
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
                  child: Hero(
                    tag: widget.product['id'],
                    child: Image.network(widget.product['imagem']),
                  )),
              Text(widget.product['nome'],
                  style: const TextStyle(fontSize: 24.0)),
              Text(widget.product['preco'],
                  style: const TextStyle(fontSize: 18.0)),
              Text(widget.product['descricao'],
                  style: const TextStyle(fontSize: 16.0))
            ]),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () {
              print(widget.product['id']);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(70.0),
                backgroundColor: Colors.deepPurple,
                elevation: 0),
            child: const Text('Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 18.0))));
  }
}
