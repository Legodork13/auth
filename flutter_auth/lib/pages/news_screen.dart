import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

List newsF = [];

class _NewsScreenState extends State<NewsScreen> {
  @override
  _getVkList() async {
    var query = {'country': 'ru', 'apiKey': '59752111ff3148eb8b5117c209436ee0'};
    var response = await http.get(
        Uri.https('newsapi.org', '/v2/top-headlines', query),
        headers: {'Content-Type': 'application/json;charset=utf-8'});

    List<String> newsfeed = [];
    List<dynamic> jsonData = jsonDecode(response.body)['articles'];
    for (var u in jsonData) {
      newsfeed.add(u['title']);
    }

    setState(() {
      newsF = newsfeed;
    });
  }

  @override
  void initState() {
    _getVkList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
        body: SingleChildScrollView(
          child: Column(
            children: newsF.map((e) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                      width: 800,
                      height: 140,
                      child: Card(
                          color: Color.fromARGB(255, 53, 52, 52),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1)),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 7, 230, 63),
                              ),
                            ),
                          ))));
            }).toList(),
          ),
        ));
  }
}
