import 'package:flutter/material.dart';
import 'ResultPage.dart';

class QuizPage extends StatefulWidget {
  final String subjectName;

  const QuizPage({super.key, required this.subjectName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int currentQuestion = 0;
  int score = 0;

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
      {
        "question": "What type of language is Dart?",
        "options": ["Compiled", "Interpreted", "Both", "None"],
        "answer": "Both",
      },
      {
        "question": "Which framework uses Dart?",
        "options": ["React", "Flutter", "Angular", "Vue"],
        "answer": "Flutter",
      },
      {
        "question": "Dart supports which programming style?",
        "options": ["OOP", "Functional", "Both", "None"],
        "answer": "Both",
      },
      {
        "question": "Which keyword is used to declare constants in Dart?",
        "options": ["let", "final", "const", "static"],
        "answer": "const",
      },
      {
        "question": "What is the file extension of Dart files?",
        "options": [".dart", ".drt", ".dt", ".d"],
        "answer": ".dart",
      },
      {
        "question": "Which operator is used for string interpolation in Dart?",
        "options": ["%", "\$", "&", "#"],
        "answer": "\$",
      },
      {
        "question": "Which data type is used for decimal numbers?",
        "options": ["int", "double", "float", "decimal"],
        "answer": "double",
      },
      {
        "question": "Which collection is key-value pair in Dart?",
        "options": ["List", "Set", "Map", "Array"],
        "answer": "Map",
      },
    ],
    "Python": [
      {
        "question": "Which keyword is used to define a function?",
        "options": ["func", "function", "def", "define"],
        "answer": "def",
      },
      {
        "question": "What is the output of print(type([]))?",
        "options": ["dict", "list", "tuple", "set"],
        "answer": "list",
      },
      {
        "question": "Which symbol is used for comments?",
        "options": ["//", "#", "/* */", "--"],
        "answer": "#",
      },
      {
        "question": "Which data type is immutable?",
        "options": ["List", "Set", "Tuple", "Dict"],
        "answer": "Tuple",
      },
      {
        "question": "Which keyword is used for inheritance?",
        "options": ["inherits", "extends", "super", "class"],
        "answer": "class",
      },
      {
        "question": "Which library is used for data analysis?",
        "options": ["numpy", "pandas", "matplotlib", "scipy"],
        "answer": "pandas",
      },
      {
        "question": "What is the output of len('hello')?",
        "options": ["3", "4", "5", "6"],
        "answer": "5",
      },
      {
        "question": "Which keyword creates a generator?",
        "options": ["yield", "return", "gen", "func"],
        "answer": "yield",
      },
      {
        "question": "Which keyword handles exceptions?",
        "options": ["try", "catch", "except", "finally"],
        "answer": "except",
      },
      {
        "question": "What is Python’s file extension?",
        "options": [".py", ".pyt", ".pt", ".python"],
        "answer": ".py",
      },
    ],
    "Java": [
      {
        "question": "Java is a ____ language.",
        "options": ["Compiled", "Interpreted", "Both", "None"],
        "answer": "Both",
      },
      {
        "question": "Which company created Java?",
        "options": ["Microsoft", "Sun Microsystems", "Oracle", "IBM"],
        "answer": "Sun Microsystems",
      },
      {
        "question": "Which keyword is used to inherit a class?",
        "options": ["super", "this", "extends", "implements"],
        "answer": "extends",
      },
      {
        "question": "Which collection does not allow duplicates?",
        "options": ["List", "Map", "Set", "ArrayList"],
        "answer": "Set",
      },
      {
        "question": "Which keyword is used to define a constant?",
        "options": ["let", "const", "final", "static"],
        "answer": "final",
      },
      {
        "question": "What is the size of int in Java?",
        "options": ["2 bytes", "4 bytes", "8 bytes", "Depends"],
        "answer": "4 bytes",
      },
      {
        "question": "Which method starts a Java program?",
        "options": ["start()", "main()", "run()", "execute()"],
        "answer": "main()",
      },
      {
        "question": "Which keyword is used for interfaces?",
        "options": ["interface", "class", "implements", "extends"],
        "answer": "interface",
      },
      {
        "question": "Which package is imported by default?",
        "options": ["java.util", "java.lang", "java.io", "None"],
        "answer": "java.lang",
      },
      {
        "question": "Which JVM memory stores objects?",
        "options": ["Stack", "Heap", "Register", "Cache"],
        "answer": "Heap",
      },
    ],
    "C++": [
      {
        "question": "Who developed C++?",
        "options": [
          "Bjarne Stroustrup",
          "Dennis Ritchie",
          "James Gosling",
          "Ken Thompson",
        ],
        "answer": "Bjarne Stroustrup",
      },
      {
        "question": "Which symbol starts a comment?",
        "options": ["//", "#", "/* */", "--"],
        "answer": "//",
      },
      {
        "question": "Which concept allows function overloading?",
        "options": [
          "Inheritance",
          "Polymorphism",
          "Encapsulation",
          "Abstraction",
        ],
        "answer": "Polymorphism",
      },
      {
        "question": "Which operator is used for pointers?",
        "options": ["*", "&", "->", "%"],
        "answer": "*",
      },
      {
        "question": "What is the size of a char?",
        "options": ["1 byte", "2 bytes", "4 bytes", "Depends"],
        "answer": "1 byte",
      },
      {
        "question": "Which keyword creates objects dynamically?",
        "options": ["malloc", "new", "alloc", "create"],
        "answer": "new",
      },
      {
        "question": "Which header is needed for cout?",
        "options": ["<stdio.h>", "<iostream>", "<stdlib.h>", "<string.h>"],
        "answer": "<iostream>",
      },
      {
        "question": "What is multiple inheritance?",
        "options": [
          "One class inherits many",
          "Many classes inherit one",
          "Class inherits many classes",
          "None",
        ],
        "answer": "Class inherits many classes",
      },
      {
        "question": "Which keyword is used for constants?",
        "options": ["let", "const", "final", "static"],
        "answer": "const",
      },
      {
        "question": "Which function is the entry point?",
        "options": ["start()", "execute()", "main()", "init()"],
        "answer": "main()",
      },
    ],
    "PHP": [
      {
        "question": "PHP stands for?",
        "options": [
          "Personal Home Page",
          "Private Home Page",
          "Public Hosting Page",
          "Programming Hypertext Processor",
        ],
        "answer": "Personal Home Page",
      },
      {
        "question": "Which symbol is used for variables?",
        "options": ["#", "\$", "@", "&"],
        "answer": "\$",
      },
      {
        "question": "Which extension do PHP files have?",
        "options": [".html", ".php", ".phtml", ".ph"],
        "answer": ".php",
      },
      {
        "question": "Which function outputs text?",
        "options": ["echo", "print", "printf", "All"],
        "answer": "All",
      },
      {
        "question": "Which keyword defines constants?",
        "options": ["const", "final", "static", "define"],
        "answer": "define",
      },
      {
        "question": "Which superglobal holds form data?",
        "options": ["\$_POST", "\$_GET", "\$_REQUEST", "All"],
        "answer": "All",
      },
      {
        "question": "PHP is ____ typed.",
        "options": ["Strongly", "Loosely", "Both", "None"],
        "answer": "Loosely",
      },
      {
        "question": "Which database is often used with PHP?",
        "options": ["MySQL", "MongoDB", "Postgres", "SQLite"],
        "answer": "MySQL",
      },
      {
        "question": "Which keyword starts a session?",
        "options": ["start()", "begin()", "session_start()", "init()"],
        "answer": "session_start()",
      },
      {
        "question": "Which keyword includes files?",
        "options": ["import", "include", "require", "Both"],
        "answer": "Both",
      },
    ],
    "Kotlin": [
      {
        "question": "Kotlin is officially supported for?",
        "options": ["iOS", "Android", "Web", "AI"],
        "answer": "Android",
      },
      {
        "question": "Which company created Kotlin?",
        "options": ["Google", "JetBrains", "Oracle", "Microsoft"],
        "answer": "JetBrains",
      },
      {
        "question": "File extension of Kotlin files?",
        "options": [".kt", ".kot", ".k", ".kotlin"],
        "answer": ".kt",
      },
      {
        "question": "Which keyword is used for inheritance?",
        "options": ["extends", "inherits", ":", "super"],
        "answer": ":",
      },
      {
        "question": "Which keyword is used to declare a function?",
        "options": ["fun", "def", "function", "func"],
        "answer": "fun",
      },
      {
        "question": "Which type system does Kotlin support?",
        "options": ["Nullable", "Non-nullable", "Both", "None"],
        "answer": "Both",
      },
      {
        "question": "Which collection is immutable?",
        "options": ["listOf()", "mutableListOf()", "arrayListOf()", "setOf()"],
        "answer": "listOf()",
      },
      {
        "question": "Which keyword defines constants?",
        "options": ["val", "const val", "final", "let"],
        "answer": "const val",
      },
      {
        "question": "Kotlin interoperates with?",
        "options": ["Swift", "C++", "Java", "Python"],
        "answer": "Java",
      },
      {
        "question": "Which keyword is used for coroutines?",
        "options": ["async", "await", "suspend", "yield"],
        "answer": "suspend",
      },
    ],
    "Swift": [
      {
        "question": "Swift is developed by?",
        "options": ["Google", "Apple", "Microsoft", "JetBrains"],
        "answer": "Apple",
      },
      {
        "question": "File extension of Swift files?",
        "options": [".sw", ".swift", ".swt", ".swf"],
        "answer": ".swift",
      },
      {
        "question": "Which keyword declares constants?",
        "options": ["let", "var", "const", "final"],
        "answer": "let",
      },
      {
        "question": "Which keyword declares variables?",
        "options": ["var", "let", "const", "val"],
        "answer": "var",
      },
      {
        "question": "Which framework is used for UI in Swift?",
        "options": ["UIKit", "Flutter", "React", "Vue"],
        "answer": "UIKit",
      },
      {
        "question": "Which collection is unordered?",
        "options": ["Array", "Set", "Dictionary", "List"],
        "answer": "Set",
      },
      {
        "question": "Which keyword is used for classes?",
        "options": ["class", "struct", "object", "data"],
        "answer": "class",
      },
      {
        "question": "Which keyword is used for structs?",
        "options": ["struct", "class", "data", "object"],
        "answer": "struct",
      },
      {
        "question": "Which keyword is used for functions?",
        "options": ["func", "fun", "function", "def"],
        "answer": "func",
      },
      {
        "question": "Swift supports ____ typing.",
        "options": ["Static", "Dynamic", "Both", "None"],
        "answer": "Both",
      },
    ],
    "JavaScript": [
      {
        "question": "JavaScript runs in?",
        "options": ["Compiler", "Browser", "Server", "Both"],
        "answer": "Browser",
      },
      {
        "question": "Which company developed JavaScript?",
        "options": ["Netscape", "Microsoft", "Oracle", "Sun"],
        "answer": "Netscape",
      },
      {
        "question": "Which symbol is used for comments?",
        "options": ["//", "#", "/* */", "--"],
        "answer": "//",
      },
      {
        "question": "Which keyword defines variables?",
        "options": ["var", "let", "const", "All"],
        "answer": "All",
      },
      {
        "question": "Which framework is based on JS?",
        "options": ["Flutter", "React", "Django", "Laravel"],
        "answer": "React",
      },
      {
        "question": "What is the output of typeof []?",
        "options": ["array", "list", "object", "undefined"],
        "answer": "object",
      },
      {
        "question": "Which operator is strict equality?",
        "options": ["==", "===", "!=", "!=="],
        "answer": "===",
      },
      {
        "question": "Which keyword handles exceptions?",
        "options": ["try", "catch", "except", "error"],
        "answer": "catch",
      },
      {
        "question": "Which JS engine is in Chrome?",
        "options": ["SpiderMonkey", "V8", "Chakra", "Rhino"],
        "answer": "V8",
      },
      {
        "question": "Which keyword creates async functions?",
        "options": ["async", "await", "promise", "then"],
        "answer": "async",
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

      // 👇 الوقت خلص
      if (remaining.inSeconds == 0) {
        if (!mounted) return;
        Future.microtask(() {
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
          content: const Text(
            "Do you want to submit the exam or review the questions?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("I review"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "${widget.subjectName} Quiz",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Text(
                  timerString,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          // ⏳ الدايرة بتاعت التايمر
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
                        valueColor: const AlwaysStoppedAnimation(Colors.black),
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

          // ❓ عرض السؤال الحالي
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

          // 🟦 عرض الاختيارات
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

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
    );
  }
}
