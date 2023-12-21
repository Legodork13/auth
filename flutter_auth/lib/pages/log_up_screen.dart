import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_test/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';

class LogUpScreen extends StatefulWidget {
  const LogUpScreen({super.key});

  @override
  State<LogUpScreen> createState() => _LogUpScreen();
}

class _LogUpScreen extends State<LogUpScreen> {
  String password = '';
  String email = '';
  String errorMessage = '';
  bool eror = false;
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    password = '';
    email = '';
    errorMessage = '';
    _controllerPassword = TextEditingController();
    _controllerEmail = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey, title: Text('Окно регистрации')),
      body: Column(
        children: [
          Container(
            child: Image.network(
              'https://i.pinimg.com/originals/d6/75/9d/d6759d08634c3d084d88c9b7b511b4ff.jpg',
              height: 80,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextFormField(
                controller: _controllerEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ad';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.login),
                    hintText: "Email"),
                onChanged: (value) {
                  setState() {
                    email = _controllerEmail.text;

                    _controllerEmail.clear();
                  }
                }),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.password),
                  hintText: "Пароль"),
              onChanged: (value) {
                setState() {
                  password = _controllerPassword.text;
                  _controllerPassword.clear();
                }
              },
            ),
          ),
          Visibility(
            visible: errorMessage != '',
            child: Center(
              child: Text(
                '$errorMessage',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _controllerEmail.text,
                        password: _controllerPassword.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        Fluttertoast.showToast(
                            msg: 'Пароль слишком простой',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red);
                      } else if (e.code == 'email-already-in-use') {
                        Fluttertoast.showToast(
                            msg: 'Email уже зарегистрирован ',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red);
                      } else {
                        _controllerPassword.clear();
                        _controllerEmail.clear();
                      }
                    } catch (e) {}
                  },
                  child: Text("Регистрация "),
                ),
              ),
              Container(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _controllerEmail.text,
                          password: _controllerPassword.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                      if (e.message ==
                          'The password is invalid or the user does not have a password.') {
                        Fluttertoast.showToast(
                            msg: 'Неправильный пароль',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red);
                      }
                    }
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
          ),
        ],
      ),
    );
  }
}
