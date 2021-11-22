import 'package:flutter/material.dart';
import '../view/authenticate/login/login_view.dart';
import '../view/authenticate/register/register_view.dart';

class Clipper extends CustomClipper<Path> {
  Clipper(this.routeId);

  final String routeId;

  @override
  Path getClip(Size size) {
    var path = Path();

    switch (routeId) {
      case LoginView.id:
        path.lineTo(0, size.height);
        path.quadraticBezierTo(size.width / 4, size.height * 0.8,
            size.width / 2, size.height * 0.9);
        path.quadraticBezierTo(
            3 * size.width / 4, size.height, size.width, size.height * 0.9);
        path.lineTo(size.width, 0);
        break;
      case RegisterView.id:
        path.lineTo(0, size.height * 0.9);
        path.quadraticBezierTo(
            size.width / 4, size.height, size.width / 2, size.height * 0.9);
        path.quadraticBezierTo(
            3 * size.width / 4, size.height * 0.8, size.width, size.height);
        path.lineTo(size.width, 0);
        break;
      default:
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
