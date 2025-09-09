import 'package:flutter/material.dart';

class Contac extends StatelessWidget {
  const Contac({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CONTAC")),
      body: const Center(
        child: Text(
          "Welcome to the ",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
