import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  final String userName;

  const NextPage({super.key, required this.userName});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, String>> subjects = [
    {"title": "Dart", "image": "images/dart.jpg"},
    {"title": "Python", "image": "images/Python.jpg"},
    {"title": "Java", "image": "images/java.jpg"},
    {"title": "C++", "image": "images/cpp.jpg"},
    {"title": "PHP", "image": "images/php.jpg"},
    {"title": "Kotlin", "image": "images/kotlin.jpg"},
    {"title": "Swift", "image": "images/swift.jpg"},
    {"title": "JavaScript", "image": "images/javescript.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 233, 192),
        title: Text("Hello, ${widget.userName} 👋"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];

            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
                  ),
                );

            final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(index * 0.1, 1.0, curve: Curves.easeOutBack),
              ),
            );

            return SlideTransition(
              position: slideAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizPage(subjectName: subject["title"]!),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            subject["image"]!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            subject["title"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuizPage extends StatelessWidget {
  final String subjectName;

  const QuizPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$subjectName Quiz")),
      body: Center(
        child: Text(
          "Welcome to the $subjectName quiz!",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
