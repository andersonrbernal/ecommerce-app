import 'package:flutter/material.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({Key? key, required this.total}) : super(key: key);

  final double total;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            height: 70,
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                          'Checkout (\$${total.toStringAsFixed(2).toString()})',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 23.0)))
                ])));
  }
}
