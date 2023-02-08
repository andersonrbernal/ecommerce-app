import 'package:client/models/user.dart';
import 'package:client/services/purchase_service.dart';
import 'package:client/widgets/purchase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({super.key});

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  late User user;
  late String uid;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    uid = user.id;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Purchases"),
          centerTitle: true,
        ),
        // drawer: ,
        body: FutureBuilder(
            future: PurchaseService.getUserPurchases(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                var purchases = data['data'];

                return ListView.builder(
                    itemCount: purchases.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Purchase(purchase: purchases[index]),
                        ));
              }
              return const Center(
                  child: Text(
                      "Ooops, something did not go well. Try again later."));
            }));
  }
}
