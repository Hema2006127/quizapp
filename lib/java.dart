import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final String subjectName;

  const QuizPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$subjectName Quiz")),
      body: Center(
        child: Text(
          "Welcome to the $subjectName qui!",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
