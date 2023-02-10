import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.indigoAccent[700],
        textStyle: const TextStyle(color: Colors.white),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.shopping_bag),
          const Text('Awesome Shop'),
          const SizedBox(height: 20),
          CircularProgressIndicator(color: Colors.indigoAccent[700])
        ]));
  }
}
