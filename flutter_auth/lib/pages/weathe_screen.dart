import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  String name = '';
  double temp = 0.0;
  double speed = 0.0;
  String description = '';
  bool _isLoading = true;
  void _getWeatherList() async {
    setState(() {
      _isLoading = true;
    });

    Dio dio = Dio();

    Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Ufa&limit=5&appid=46d98b0070a1600dcaad5874b97e9c9b&units=metric&lang=ru');

    setState(() {
      name = response.data['name'];
      temp = response.data['main']['temp'];
      speed = response.data['wind']['speed'];
      description = response.data['weather'][0]['description'];
      _isLoading = false;
    });
  }

  void initState() {
    _getWeatherList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Image.network(
                  'https://babich.biz/content/images/2016/11/6-1.png',
                  height: 100,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '$name',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: Text(
                  '$description',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: Text(
                  'Температура: $temp',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: Text(
                  'Ветер: $speed м.с',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ]),
    );
  }
}
