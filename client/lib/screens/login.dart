import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';

import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _sessionManager = SessionManager();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String errorMessage = '';

  late String email;
  late String password;

  Future<void> login(String email, String password) async {
    errorMessage = '';

    Map<String, String> requestBody = {'email': email, 'password': password};
    Auth auth = Auth(endpoint: 'auth/login', requestBody: requestBody);
    Response response = await auth.login();
    Map<String, dynamic> data = await jsonDecode(response.body);

    bool responseNotOk = response.statusCode != 200;
    if (responseNotOk) {
      Map errors = data['errors'];

      setState(() => errorMessage = errors.values.first);
      return;
    }

    await _sessionManager.set('token', data['token']);
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
                Text('Login', style: TextStyle(fontSize: 30.0))
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
                controller: _emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email.'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password your email.')),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('New User? Create an account',
                    style: TextStyle(fontSize: 15.0)),
              ),
              MaterialButton(
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                      email = _emailController.value.text;
                      password = _passwordController.value.text;
                    });
                    await login(email, password);
                    _loading = false;
                  },
                  color: Colors.blue,
                  child: _loading
                      ? const Text('Loading',
                          style: TextStyle(fontSize: 16.0, color: Colors.white))
                      : const Text('Login',
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.white)))
            ],
          )),
    );
  }
}
