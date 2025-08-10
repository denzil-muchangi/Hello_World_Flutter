import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 8.0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 28),
            children: const <TextSpan>[
              TextSpan(
                text: 'Hello',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              TextSpan(
                text: ' World',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    ', Flutter',
                    style: TextStyle(
                      color: Colors.green,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Georgia',
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    ' !!!',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}