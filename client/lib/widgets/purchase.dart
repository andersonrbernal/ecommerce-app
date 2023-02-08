import 'package:client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Purchase extends StatefulWidget {
  const Purchase({super.key, required this.purchase});

  final Map<String, dynamic> purchase;

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  late User user;
  late String username;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    username = user.username;

    return Card(
      child: Column(children: [
        ListTile(
          leading: const Icon(Icons.shopify),
          title: Text('Purchase made by $username'),
          subtitle: Text('Date: ${widget.purchase["createdAt"]}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('Quantity ${widget.purchase['cart'].length}',
                style: const TextStyle(fontSize: 16.0)),
            const SizedBox(width: 20),
            Text('Total \$${widget.purchase['total']}.00',
                style: const TextStyle(fontSize: 16.0))
          ]),
        )
      ]),
    );
  }
}
