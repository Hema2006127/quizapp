import 'package:flutter/material.dart';
import 'categorypage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeImage, _fadeTextField, _fadeButton, _fadeTitle;
  late Animation<Offset> _slideImage,
      _slideTextField,
      _slideButton,
      _slideTitle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeTitle = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.3)),
    );
    _fadeImage = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.5)),
    );
    _fadeTextField = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.8)),
    );
    _fadeButton = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0)),
    );

    _slideTitle = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideImage = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideTextField = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideButton = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(
                    255,
                    255,
                    253,
                    253,
                  ).withValues(alpha: 0.5),
                  const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // المحتوى
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // العنوان
                    SlideTransition(
                      position: _slideTitle,
                      child: FadeTransition(
                        opacity: _fadeTitle,
                        child: Text(
                          "Welcome to Quiz App",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: const Color.fromARGB(
                                  255,
                                  156,
                                  154,
                                  154,
                                ).withOpacity(0.6),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // صورة
                    SlideTransition(
                      position: _slideImage,
                      child: FadeTransition(
                        opacity: _fadeImage,
                        child: const CircleAvatar(
                          radius: 65,
                          backgroundImage: AssetImage("images/s1.jpg"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // التكست فيلد
                    SlideTransition(
                      position: _slideTextField,
                      child: FadeTransition(
                        opacity: _fadeTextField,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter your name",
                              prefixIcon: Icon(Icons.person),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // الزرار
                    SlideTransition(
                      position: _slideButton,
                      child: FadeTransition(
                        opacity: _fadeButton,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 6,
                          ),
                          onPressed: () {
                            if (nameController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter your name first"),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NextPage(userName: nameController.text),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Start Quiz",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
