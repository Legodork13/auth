import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_test/pages/log_up_screen.dart';
import 'log_up_screen.dart';
import 'login_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.green, title: Text('Главное окно')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.login),
                  hintText: "Телефон или почта"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.password),
                  hintText: "Пароль"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogUpScreen()));
                    },
                    child: Text('Зарегистрироваться')),
              ),
              Container(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
