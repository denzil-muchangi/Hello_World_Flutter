import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}