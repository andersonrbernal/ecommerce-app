import 'package:client/widgets/product_on_cart.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            title: const Text('Cart', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
            alignment: Alignment.center,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const ProductOnCart();
                })),
        bottomSheet: Container(
            height: 70,
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text('Checkout (\$0.00)',
                          style:
                              TextStyle(color: Colors.white, fontSize: 23.0)))
                ])));
  }
}
