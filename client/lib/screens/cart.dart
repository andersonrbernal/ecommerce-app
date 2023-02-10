import 'package:client/models/user.dart';
import 'package:client/services/cart_service.dart';
import 'package:client/widgets/product_item.dart';
import 'package:client/widgets/purchase_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late User user;
  late String uid;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    uid = user.id;
    CartService cartService = CartService(uid);

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            title: const Text('Cart'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            toolbarTextStyle: const TextStyle(color: Colors.black),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
            alignment: Alignment.center,
            child: FutureBuilder<List>(
                future: cartService.getCartProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent[700]));
                  } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("Your cart is empty.",
                            style: TextStyle(fontSize: 18.0)));
                  } else if (snapshot.hasData) {
                    var cartItemsList = snapshot.data!;
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cartItemsList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: Key(index.toString()),
                              background: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.red),
                              ),
                              onDismissed: (direction) {
                                removeProduct(
                                    cartService, cartItemsList[index]['id']);
                                setState(() {
                                  cartItemsList.removeAt(index);
                                });
                              },
                              child: ProductItem(
                                cartItemsList: cartItemsList,
                                index: index,
                              ));
                        });
                  }
                  return const Center(
                      child: Text('Ooops, something went wrong.'));
                })),
        bottomNavigationBar: FutureBuilder(
            future: cartService.getCart(),
            builder: (context, snapshot) {
              late int total;
              if (snapshot.hasData) {
                total = snapshot.data!['total'];
                return PurchaseButton(total: total.toDouble());
              }

              return const PurchaseButton(total: 0.00);
            }));
  }
}

Future<void> removeProduct(CartService cartService, String productId) async {
  try {
    await cartService.removeProduct(int.parse(productId));
  } catch (e) {
    rethrow;
  }
}
