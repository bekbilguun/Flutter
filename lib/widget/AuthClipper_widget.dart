import 'package:flutter/material.dart';

class AuthClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 1.2);
    var controlPoint2 = Offset(size.width / 2.5, size.height / 2);
    var controlPoint = Offset(size.width / 1.5, size.height * 1.25);
    var endPoint = Offset(size.width, size.height / 1.25);
    // path.quadraticBezierTo(
    //     controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.cubicTo(controlPoint.dx, controlPoint.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
