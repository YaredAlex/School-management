import 'package:flutter/material.dart';

class CCustomShape extends CustomClipper<Path> {
  final double radius;
  CCustomShape({this.radius = 50});
  @override
  Path getClip(Size size) {
    var path = Path();

    // Draw line to the top-right corner
    path.lineTo(0, size.height);

    var controlPoint1 = Offset(0, size.height - radius);
    var endPoint1 = Offset(radius, size.height - radius);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);
    var controlPoint2 = Offset(0, size.height - radius);
    var endPoint2 = Offset(size.width - radius, size.height - radius);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);
    // Draw line to the bottom-left corner with an upward curve
    var controlPoint3 =
        Offset(size.width, size.height - radius); // Control point for the curve
    var endPoint3 = Offset(size.width, size.height); // End point for the curve
    path.quadraticBezierTo(
        controlPoint3.dx, controlPoint3.dy, endPoint3.dx, endPoint3.dy);

    // Draw line back to the top-left corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
