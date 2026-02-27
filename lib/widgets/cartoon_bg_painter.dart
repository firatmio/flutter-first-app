import 'package:flutter/material.dart';
import '../theme/cartoon_theme.dart';

/// Cartoon Network tarzı dalgalı arka plan boyacı
class CartoonBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Alt dalga - pembe
    final wavePaint1 = Paint()
      ..color = CartoonTheme.accentPink.withValues(alpha: 0.13)
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, size.height * 0.85)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.75, size.width * 0.5, size.height * 0.85)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.95, size.width, size.height * 0.82)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path1, wavePaint1);

    // Üst dalga - mavi
    final wavePaint2 = Paint()
      ..color = CartoonTheme.accentBlue.withValues(alpha: 0.10)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(0, size.height * 0.12)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.05, size.width * 0.6, size.height * 0.12)
      ..quadraticBezierTo(
          size.width * 0.85, size.height * 0.18, size.width, size.height * 0.08)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path2, wavePaint2);

    // Dekoratif daireler
    final circlePaint = Paint()
      ..color = CartoonTheme.accentYellow.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.3), 40, circlePaint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.6), 55, circlePaint);

    final circlePaint2 = Paint()
      ..color = CartoonTheme.accentPurple.withValues(alpha: 0.09)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.2), 30, circlePaint2);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.75), 35, circlePaint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
