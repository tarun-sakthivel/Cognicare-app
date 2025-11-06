import 'package:flutter/material.dart';

class DiagnoseCard extends StatelessWidget {
  const DiagnoseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SlantClipper(),
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(
          children: [
            // Text
            const Positioned(
              left: 20,
              top: 20,
              child: Text(
                "Diagnose",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Doctor Icon (top right)
            const Positioned(
              right: 20,
              top: 10,
              child: Icon(
                Icons.medical_services, // Replace with custom image if needed
                size: 60,
                color: Colors.white,
              ),
            ),

            // Circle button (bottom left)
            Positioned(
              left: 20,
              bottom: 15,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.arrow_outward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 15.0;

    Path path = Path();

    // Start from bottom-left rounded corner
    path.moveTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);

    // Bottom edge
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);

    // Right edge
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    // Top slant (diagonal cut instead of straight)
    path.lineTo(40, 20);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 25, 0, radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
