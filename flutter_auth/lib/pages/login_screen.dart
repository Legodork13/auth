import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_test/pages/news_screen.dart';
import 'package:flutter_auth_test/pages/weathe_screen.dart';

import 'log_up_screen.dart';
import 'sanek.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _getVkList() async {
    Dio dio = Dio();
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=59752111ff3148eb8b5117c209436ee0');
    print(response.data);
  }

  void _getWeatherList() async {
    Dio dio = Dio();
    Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Ufa&limit=5&appid=46d98b0070a1600dcaad5874b97e9c9b&units=metric&lang=ru');
    setState(() {});
  }

  int _selected = 0;
  void onSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.green, title: Text('Личный кабнет')),
          body: Column(children: [
            TabBar(labelColor: Colors.black, tabs: [
              Tab(
                text: 'Погода',
                icon: Icon(Icons.sunny),
              ),
              Tab(
                text: 'Новости',
                icon: Icon(Icons.newspaper),
              ),
              Tab(
                text: 'sanek))',
              ),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  WeatherScreen(),
                  NewsScreen(),
                  Sanek(),
                ],
              ),
            ),
          ]),
        ));
  }
}
