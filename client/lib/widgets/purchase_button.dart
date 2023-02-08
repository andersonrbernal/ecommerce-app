import 'package:client/models/user.dart';
import 'package:client/services/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseButton extends StatefulWidget {
  const PurchaseButton({Key? key, required this.total}) : super(key: key);

  final double total;

  @override
  State<PurchaseButton> createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton> {
  late User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return Material(
        child: Container(
            height: 70,
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).popAndPushNamed('/purchases');
                        await PurchaseService.registerPurchase(user.id);
                      },
                      child: Text(
                          'Checkout (\$${widget.total.toStringAsFixed(2).toString()})',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 23.0)))
                ])));
  }
}
