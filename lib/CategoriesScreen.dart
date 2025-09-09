import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        toolbarHeight: 45.0,
        backgroundColor: const Color(0xFF222831),
        title: const Text(
          "Welcome🖐",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
            ),
            const Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/s1.jpg"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 173, 181),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: ":Enter your name",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
        ),
        
      ),
      
    );
  }
}
