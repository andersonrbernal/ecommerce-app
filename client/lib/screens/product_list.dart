import 'package:client/services/provider.dart';
import 'package:client/widgets/data_search.dart';
import 'package:client/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Provider provider = Provider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: const Text('Awesome Shop'), actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ]),
        body: ProductGridView(provider: provider));
  }
}
