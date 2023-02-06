import 'package:client/models/user.dart';
import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = SessionManager();
  late User user;

  bool _loading = false;
  String errorMessage = '';

  Future<bool> signup(String username, String email, String password) async {
    _storage.destroy();
    try {
      var data = await Auth.signup(username, email, password);

      if (data['success'] == false) {
        setState(() => errorMessage = data['errors'].values.first);
        return false;
      }
      await _storage.set("token", data['token']);
      return true;
    } catch (e) {
      setState(
          () => errorMessage = "We could not get response from our server.");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username.'),
              ),
              const SizedBox(height: 20.0),
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
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: const Text('Already have an account? Login',
                    style: TextStyle(fontSize: 15.0)),
              ),
              MaterialButton(
                  onPressed: () async {
                    setState((() => _loading = true));

                    bool isLoggedIn = await signup(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (isLoggedIn) {
                      String jwt = await _storage.get('token');
                      user.token = jwt.toString();
                      Navigator.pushReplacementNamed(context, '/products');
                    }

                    setState((() => _loading = false));
                  },
                  color: Colors.blue,
                  child: _loading
                      ? const Text('Loading',
                          style: TextStyle(fontSize: 16.0, color: Colors.white))
                      : const Text('Singup',
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.white)))
            ])));
  }
}
