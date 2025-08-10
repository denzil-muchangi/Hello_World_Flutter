import 'package:flutter/material.dart';
import 'package:hello_world/root/widgets/app_bar.dart';
import 'package:hello_world/root/widgets/body.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
    );
  }
}