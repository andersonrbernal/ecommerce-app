import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String name;

  late String price;

  late String description;

  late String picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              name,
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
                  alignment: Alignment.center, child: Image.network(picture)),
              Text(name, style: const TextStyle(fontSize: 24.0)),
              Text(price, style: const TextStyle(fontSize: 18.0)),
              Text(description, style: const TextStyle(fontSize: 16.0))
            ]),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(70.0),
                backgroundColor: Colors.deepPurple,
                elevation: 0),
            child: const Text('Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 18.0))));
  }
}
