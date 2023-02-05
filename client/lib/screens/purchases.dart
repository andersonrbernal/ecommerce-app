import 'package:flutter/material.dart';

class Purchases extends StatefulWidget {
  const Purchases({super.key});

  @override
  State<Purchases> createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Purchases',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0),
        body: Column(children: const [Text('Purchases')]));
  }
}
