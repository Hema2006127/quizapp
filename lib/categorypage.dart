import 'package:flutter/material.dart';
import 'package:quiz_app/loginpage.dart';
import 'package:quiz_app/prequiz.dart';

class CategoryPage extends StatefulWidget {
  final String userName;

  const CategoryPage({super.key, required this.userName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
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
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Hello, ${widget.userName} 👋",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 4),
            onEnd: () => setState(() {}),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.grey.shade900, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          ListView.builder(
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];

              final slideAnimation =
                  Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
                    ),
                  );

              final scaleAnimation = Tween<double>(begin: 0.9, end: 1.0)
                  .animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        index * 0.1,
                        1.0,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                  );

              final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(index * 0.1, 1.0, curve: Curves.easeIn),
                ),
              );

              return FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PreQuizPage(
                              subjectName: subject["title"]!,
                              quizImage: subject["image"]!,
                              username: widget.userName,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 15,
                        shadowColor: Colors.blueAccent.withOpacity(0.5),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Hero(
                              tag: subject["title"]!,
                              child: Image.asset(
                                subject["image"]!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 18,
                              left: 20,
                              child: Text(
                                subject["title"]!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Homepage()),
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white, size: 28),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(" بعدين بقي ان شاء الله")),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white, size: 28),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("  بعدين بقي ان شاء الله ")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
