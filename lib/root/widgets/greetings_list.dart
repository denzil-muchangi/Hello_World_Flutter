import 'package:flutter/material.dart';
import 'package:hello_world/root/data/greetings.dart';

class GreetingsList extends StatelessWidget {
  const GreetingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: greetings.length,
      itemBuilder: (context, index) {
        String key = greetings.keys.elementAt(index);
        return ListTile(
          title: Text(key, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(greetings[key]!, style: const TextStyle(color: Colors.white)),
        );
      },
    );
  }
}