import 'package:client/models/user.dart';
import 'package:client/services/product_provider.dart';
import 'package:client/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView(
      {Key? key, required this.productProvider, this.value = ''})
      : super(key: key);

  final ProductProvider productProvider;
  final String value;

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  late User user;

  late String uid;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    uid = user.id;

    return FutureBuilder<List<dynamic>>(
        future: widget.value.isEmpty
            ? widget.productProvider.getProductsThatAreNotInCart(uid)
            : widget.productProvider.searchProducts(widget.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<dynamic> products = snapshot.data!;

            return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) =>
                    ProductCard(product: products[index]));
          }

          return const Center(child: Text('Ooops, something went wrong.'));
        });
  }
}
