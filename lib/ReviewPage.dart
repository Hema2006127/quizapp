import 'package:flutter/material.dart';
import 'globel.dart';

class ReviewPage extends StatelessWidget {
  final String subjectName;
  final List<String?> selectedAnswers;

  const ReviewPage({
    super.key,
    required this.subjectName,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final questions = Globel.quizData[subjectName]!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final correctAnswer = question["answer"] as String?;
          final selected = selectedAnswers[index];

          return Card(
            elevation: 6,
            shadowColor: Colors.white24,
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${index + 1}: ${question["question"]}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...((question["options"] as List<String>).map((o) {
                    Color bgColor = Colors.grey[800]!;
                    Color textColor = Colors.white;

                    if (o == correctAnswer) {
                      bgColor = Colors.greenAccent.shade700;
                      textColor = Colors.black;
                    } else if (o == selected && o != correctAnswer) {
                      bgColor = Colors.redAccent.shade700;
                      textColor = Colors.white;
                    } else if (o == selected && o == correctAnswer) {
                      bgColor = Colors.greenAccent.shade400;
                      textColor = Colors.black;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        o,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    );
                  }).toList()),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white24),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[900],
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر الرجوع على شكل أيقونة نتايج
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade700,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.shade400.withOpacity(0.6),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events, // أيقونة Trophy
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),

              // نص المعلومات
              Text(
                "$subjectName - ${questions.length} Questions",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 44), // للتوازن مع حجم الأيقونة
            ],
          ),
        ),
      ),
    );
  }
}
