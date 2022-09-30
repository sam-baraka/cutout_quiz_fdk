import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Cutout(
          size: 50,
          size2: 30,
        ),
      ),
    );
  }
}

class Cutout extends StatelessWidget {
  final double size;
  final double size2;
  const Cutout({super.key, required this.size, required this.size2});

  @override
  Widget build(BuildContext context) {
    double size2 = 30;
    return SizedBox(
      height: size + size2 / 2,
      width: size + size2 / 2,
      child: Stack(children: [
        Positioned(
          bottom: (size2 / 2),
          right: (size2 / 2),
          child: ClipPath(
            clipper: ClippedPath(dimension: size2),
            child: CircleAvatar(
              radius: size / 2,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: size2 / 2,
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        )
      ]),
    );
  }
}

class ClippedPath extends CustomClipper<Path> {
  final double dimension;
  ClippedPath({
    required this.dimension,
  });

  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addOval(
        Rect.fromCenter(
            center: Offset(size.width, size.height),
            width: dimension,
            height: dimension),
      )
      ..addRect(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant ClippedPath oldClipper) {
    return dimension != oldClipper.dimension;
  }
}
