import 'package:flutter/material.dart';
import 'QuizPage.dart';

class PreQuizPage extends StatelessWidget {
  final String subjectName;
  final String quizImage;

  const PreQuizPage({
    super.key,
    required this.subjectName,
    required this.quizImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 233, 192),
      appBar: AppBar(title: Text("$subjectName Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الصورة + التايمر جمب بعض
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(quizImage),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 240, 236, 236),
                      width: 4,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "20:00",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(221, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // زرار البداية
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PreQuizPage(
                      subjectName: subjectName,
                      quizImage: quizImage,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Start Quiz",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
