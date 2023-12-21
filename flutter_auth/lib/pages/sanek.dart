import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Sanek extends StatefulWidget {
  const Sanek({super.key});

  @override
  State<Sanek> createState() => _SanekState();
}

class _SanekState extends State<Sanek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.network(
                'https://ae01.alicdn.com/kf/HTB1pb.Xd_tYBeNjy1Xdq6xXyVXa4.jpg')));
  }
}
