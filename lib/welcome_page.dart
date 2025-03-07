import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
      debugShowCheckedModeBanner: false, // Removes the debug banner
    );
  }
}

// Convert the CustomPainter to CustomClipper
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Top curve
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.6, 0);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.1,
        size.width * 0.3, size.height * 0.35);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.45, 0, size.height * 0.4);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Bottom curve
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.75,
        size.width * 0.5, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.75, size.width * 0.4, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background with gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFA07A), // Orange shade
                  Color(0xFFB0E0E6), // Light blue
                  Color(0xFF4682B4), // Dark blue
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Top curve shape
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                color: const Color(0xFFF4A261),
              ),
            ),
          ),

          // Bottom curve shape
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                color: const Color(0xFF004c6d),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/signup'); // Navigate to Sign-Up
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Click to get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
