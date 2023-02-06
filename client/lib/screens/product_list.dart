import 'package:client/models/user.dart';
import 'package:client/services/product_provider.dart';
import 'package:client/widgets/data_search.dart';
import 'package:client/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late User user;

  ProductProvider productProvider = ProductProvider();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    print(user.token);

    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
              title: const Text('Awesome Shop',
                  style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    }),
                IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    })
              ]),
          body: ProductGridView(productProvider: productProvider));
    });
  }
}
