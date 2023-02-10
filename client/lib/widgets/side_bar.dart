import 'package:client/screens/login.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Colors.indigoAccent[700],
            child: DrawerHeader(
                child: Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 38,
                          width: 38,
                          child: Image.asset('assets/images/user.png'))
                    ]),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(username,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            )),
          ),
          ListTile(
            title: Row(children: const [
              Icon(Icons.shopping_bag, color: Color.fromARGB(255, 241, 94, 53)),
              SizedBox(width: 20),
              Text('Purchases')
            ]),
            onTap: () => Navigator.popAndPushNamed(context, '/purchases'),
          ),
          ListTile(
              title: Row(children: const [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 20),
                Text('Log out')
              ]),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false);
              })
        ],
      ),
    );
  }
}
