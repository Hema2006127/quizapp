import 'package:flutter/material.dart';
import 'package:quiz_app/loginpage.dart';
import 'categorypage.dart';
import 'loginpage.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final String userName;
  final String subjectName;
  final Duration? elapsedTime;

  const ResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.userName,
    required this.subjectName,
    this.elapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = elapsedTime != null
        ? "${elapsedTime!.inMinutes} min ${elapsedTime!.inSeconds % 60} sec"
        : "";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Test result"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "انتهى الوقت",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "النتيجة: $score / $total",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "الوقت المستغرق: $formattedTime",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 30),

            // زر الذهاب لصفحة Login (Homepage)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Homepage(), // ⬅️ هنا بنستخدم Homepage
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("🔑 Go to Login Page"),
            ),

            const SizedBox(height: 15),

            // زر الذهاب لصفحة اختيار المواد
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(userName: userName),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("📚 Go to Categories Page"),
            ),
          ],
        ),
      ),
    );
  }
}
