import 'package:client/services/provider.dart';
import 'package:client/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key, required this.provider, this.value = ''})
      : super(key: key);

  final Provider provider;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: value.isEmpty
            ? provider.getProducts()
            : provider.searchProducts(value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<dynamic> products = snapshot.data!;

            return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Hero(
                      tag: 'product_${index.toString()}',
                      child: ProductCard(
                          key: key,
                          name: products[index]['nome'],
                          picture: products[index]['imagem'],
                          price: products[index]['preco']),
                    ));
          }

          return const Center(child: Text('Ooops, something went wrong.'));
        });
  }
}
