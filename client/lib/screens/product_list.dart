import 'package:client/models/user.dart';
import 'package:client/screens/login.dart';
import 'package:client/services/product_provider.dart';
import 'package:client/widgets/data_search.dart';
import 'package:client/widgets/product_grid_view.dart';
import 'package:client/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late User user;
  late String username;
  late String email;
  late String uid;

  ProductProvider productProvider = ProductProvider();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    username = user.username;
    email = user.email;
    uid = user.id;

    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
              title: const Text('Awesome Shop',
                  style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    }),
                IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    }),
              ]),
          drawer: SideBar(username: username, email: email),
          body: ProductGridView(productProvider: productProvider));
    });
  }
}
