import 'package:flutter/material.dart';
import 'resultpage.dart';

class QuizPage extends StatefulWidget {
  final String subjectName;

  const QuizPage({super.key, required this.subjectName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int score = 0;
  int currentQuestion = 0;

  final Map<String, List<Map<String, Object>>> quizData = {
    "Dart": [
      {
        "question": "What is Dart mainly used for?",
        "options": ["Web", "Mobile", "AI", "Networking"],
        "answer": "Mobile",
      },
      {
        "question": "Which company developed Dart?",
        "options": ["Google", "Microsoft", "Facebook", "Apple"],
        "answer": "Google",
      },
    ],
    "Python": [
      {
        "question": "Which keyword is used to define a function?",
        "options": ["func", "function", "def", "define"],
        "answer": "def",
      },
    ],
  };

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    )..forward();

    _controller.addListener(() {
      final remaining = _controller.duration! * (1.0 - _controller.value);

      // نص الوقت
      if (remaining.inMinutes == 1 && remaining.inSeconds % 60 == 0) {
        if (!mounted) return;
        Future.microtask(() {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("⏳ Alert"),
              content: const Text("Only half the time left!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ok"),
                ),
              ],
            ),
          );
        });
      }

      // الوقت خلص
      if (remaining.inSeconds == 0) {
        if (!mounted) return;
        Future.microtask(() {
          final elapsedTime = _controller.duration!;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ResultPage(
                score: score,
                total: quizData[widget.subjectName]!.length,
              ),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  void checkAnswer(String answer) {
    final correct =
        quizData[widget.subjectName]![currentQuestion]["answer"] as String;
    if (answer == correct) score++;

    if (currentQuestion < quizData[widget.subjectName]!.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("The questions are finished."),
          content: const Text("Do you want to submit the exam or review?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Review"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                final elapsedTime = _controller.duration! * _controller.value;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultPage(
                      score: score,
                      total: quizData[widget.subjectName]!.length,
                    ),
                  ),
                );
              },
              child: const Text("Finish Quiz"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = quizData[widget.subjectName]!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),

          // تايمر دائري
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 1.0 - _controller.value,
                        strokeWidth: 10,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                      Text(
                        timerString,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 40),

          // السؤال
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              questions[currentQuestion]["question"] as String,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // الخيارات
          ...(questions[currentQuestion]["options"] as List<String>).map((
            option,
          ) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: ElevatedButton(
                onPressed: () => checkAnswer(option),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(option, style: const TextStyle(fontSize: 16)),
              ),
            );
          }),

          const Spacer(),

          // زرار إنهاء الامتحان
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                final elapsedTime = _controller.duration! * _controller.value;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultPage(
                      score: score,
                      total: quizData[widget.subjectName]!.length,
                    ),
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
              child: const Text(
                "Finish Quiz",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),

      // 👇 bottomNavigationBar بدل AppBar
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.subjectName} Quiz",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Text(
                    timerString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
