import 'package:client/services/provider.dart';
import 'package:client/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final int index;
  const ProductDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Provider provider = Provider();

    return Hero(
        tag: index.toString(),
        child: FutureBuilder(
            future: provider.findProduct(index.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<dynamic> product = snapshot.data!;

                return Center(
                  child: Hero(
                      tag: 'product_${index.toString()}',
                      child: ProductCard(
                        name: product[0]['nome'],
                        picture: product[0]['imagem'],
                        price: product[0]['preco'],
                      )),
                );
              }

              return const Center(child: Text('Ooops, something went wrong.'));
            }));
  }
}
