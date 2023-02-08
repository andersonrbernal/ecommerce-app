import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  const Purchase({super.key, required this.purchase});

  final Map<String, dynamic> purchase;

  @override
  Widget build(BuildContext context) {
    return Text(purchase['userId']);
  }
}
