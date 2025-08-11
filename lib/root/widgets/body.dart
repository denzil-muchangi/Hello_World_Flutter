import 'package:flutter/material.dart';
import 'package:hello_world/root/widgets/greetings.dart';

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
      child: ListView.builder(
        itemCount: greetings.length,
        itemBuilder: (context, index) {
          String key = greetings.keys.elementAt(index);
          return ListTile(
            title: Text(key, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(greetings[key]!, style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}