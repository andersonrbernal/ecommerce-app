import 'package:client/screens/cart.dart';
import 'package:client/screens/login.dart';
import 'package:client/screens/product_list.dart';
import 'package:client/screens/purchases.dart';
import 'package:client/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        initialRoute: '/login',
        routes: {
          '/': (context) => const ProductList(),
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/cart': (context) => const Cart(),
          '/purchases': (context) => const Purchases()
        });
  }
}
