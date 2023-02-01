import 'dart:convert';
import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  String username = '';
  String email = '';
  String password = '';

  Future<void> signup() async {
    errorMessage = '';

    Map<String, String> requestBody = {
      'username': username,
      'email': email,
      'password': password
    };

    Auth auth = Auth(endpoint: 'auth/register', requestBody: requestBody);
    Response response = await auth.signup();
    Map<String, dynamic> data = await jsonDecode(response.body);

    if (response.statusCode != 200) {
      Map errors = data['errors'];

      setState(() {
        errorMessage = errors.values.first;
      });
      print(errorMessage);
      return;
    }

    print(response.statusCode);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Text('Signup', style: TextStyle(fontSize: 30.0))
              ]),
              const SizedBox(height: 40.0),
              Visibility(
                  visible: true,
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )),
              const SizedBox(height: 40.0),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username.'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email.'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password your email.')),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Already have an account? Login',
                    style: TextStyle(fontSize: 15.0)),
              ),
              MaterialButton(
                  onPressed: () {
                    setState(() {
                      username = _usernameController.value.text;
                      email = _emailController.value.text;
                      password = _passwordController.value.text;
                    });
                    signup();
                  },
                  color: Colors.blue,
                  child: const Text('Login',
                      style: TextStyle(fontSize: 16.0, color: Colors.white))),
            ],
          )),
    );
  }
}
