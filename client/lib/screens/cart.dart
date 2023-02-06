import 'package:client/models/user.dart';
import 'package:client/widgets/product_on_cart.dart';
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
            child: ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ProductOnCart(
                    name: 'product',
                    picture:
                        'https://loremflickr.com/cache/resized/65535_50361596851_4b40f7475b_b_640_480_nofilter.jpg',
                    price: '0.00',
                  );
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
