// QuizPage.dart
import 'package:flutter/material.dart';
import 'package:quiz_app/globel.dart';
import 'ResultPage.dart';

class QuizPage extends StatefulWidget {
  final String subjectName;
  final String userName;

  const QuizPage({
    super.key,
    required this.subjectName,
    required this.userName,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int currentQuestion = 0;
  int score = 0;
  bool _halfTimeShown = false;
  late List<String?> selectedAnswers;

  @override
  void initState() {
    super.initState();
    final questions = Globel.quizData[widget.subjectName]!;
    selectedAnswers = List<String?>.filled(questions.length, null);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    )..forward();

    _controller.addListener(() {
      final remaining = _controller.duration! * (1.0 - _controller.value);
      if (!_halfTimeShown &&
          remaining.inMinutes == 1 &&
          remaining.inSeconds % 60 == 0) {
        _halfTimeShown = true;
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (_) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.yellow,
                  size: 50,
                ),
                const SizedBox(height: 12),
                const Text(
                  "⚠️ Half Time Alert!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Only 1 minute left, stay focused 👀",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Got it"),
                ),
              ],
            ),
          ),
        );
      }

      if (remaining.inSeconds == 0) _showFinishDialog();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Duration get elapsedTime => _controller.duration! * _controller.value;

  String get timerString {
    Duration duration = _controller.duration! * (1.0 - _controller.value);
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String seconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Submit Quiz"),
        content: const Text(
          "You have reached the last question. Do you want to submit or review your answers?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Review"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              finishQuiz();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void finishQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
          score: score,
          total: Globel.quizData[widget.subjectName]!.length,
          userName: widget.userName,
          subjectName: widget.subjectName,
          elapsedTime: elapsedTime,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswers[currentQuestion] = answer;
      final correct =
          Globel.quizData[widget.subjectName]![currentQuestion]["answer"]
              as String;
      if (answer == correct) score++;

      // إذا وصلنا للسؤال الأخير نعرض مربع الحوار
      if (currentQuestion < Globel.quizData[widget.subjectName]!.length - 1) {
        currentQuestion++;
      } else {
        _showFinishDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = Globel.quizData[widget.subjectName]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "${widget.subjectName} Quiz",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // تايمر دائري
            Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                  color: Colors.black54,
                ),
                alignment: Alignment.center,
                child: Text(
                  timerString,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // السؤال
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                questions[currentQuestion]["question"] as String,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),

            // الاختيارات بأزرار أكبر
            ...(questions[currentQuestion]["options"] as List<String>).map((o) {
              Color btnColor = Colors.white;
              if (selectedAnswers[currentQuestion] == o)
                btnColor = Colors.yellow;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(o),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: btnColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      o,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            // دائرة حالة كل سؤال مع التنقل
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Color color;
                  if (selectedAnswers[index] != null)
                    color = Colors.green;
                  else if (index == currentQuestion)
                    color = Colors.yellow;
                  else
                    color = Colors.red;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentQuestion = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // زر إنهاء الامتحان بعرض الشاشة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showFinishDialog,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Finish Quiz",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
