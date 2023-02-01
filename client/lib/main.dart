import 'package:client/screens/home.dart';
import 'package:client/screens/login.dart';
import 'package:client/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_session_manager/flutter_session_manager.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // dynamic user = await SessionManager().set('token', 'value');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup()
      },
    );
  }
}
