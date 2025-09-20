import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final Duration elapsedTime; // ✅ ضفنا ده

  const ResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.elapsedTime, // ✅ لازم تبعته من QuizPage
  });

  String formatDuration(Duration d) {
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // بدل AppBar خليتها Bottom Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Exam Finished",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "⏳ Time Out",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Result: $score / $total",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              "Elapsed Time: ${formatDuration(elapsedTime)}",
              style: const TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
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
              child: const Text("Go to Quiz Page"),
            ),
          ],
        ),
      ),
    );
  }
}
