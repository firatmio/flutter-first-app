import 'package:flutter/material.dart';

/// Cartoon Network tarzı tema: kalın siyah outline, canlı renkler, balon formlar
class CartoonTheme {
  // Not kartı renkleri – canlı, parlak, çizgi film tarzı
  static const List<Color> noteColors = [
    Color(0xFFFFE066), // Sarı - Adventure Time
    Color(0xFFFF6B6B), // Kırmızı - Powerpuff Girls Blossom
    Color(0xFF74D9FF), // Mavi - Regular Show
    Color(0xFF95F9A3), // Yeşil - Ben 10
    Color(0xFFFF9FF3), // Pembe - Powerpuff Girls Bubbles
    Color(0xFFFFB347), // Turuncu - Dexter's Lab
    Color(0xFFC3ABFF), // Mor - Foster's Home
    Color(0xFF6BFFDC), // Turkuaz - Courage
  ];

  static const Color bgColor = Color(0xFFFFF5E6);
  static const Color darkOutline = Color(0xFF2D2D2D);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentBlue = Color(0xFF4ECDC4);
  static const Color accentYellow = Color(0xFFFFE66D);
  static const Color accentPurple = Color(0xFFA66CFF);
  static const Color white = Color(0xFFFFFFFF);

  /// Kalın siyah kenarlıklı cartoon box decoration
  static BoxDecoration cartoonBox({
    Color color = const Color(0xFFFFE066),
    double borderWidth = 3.5,
    double radius = 20,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: darkOutline, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: darkOutline.withValues(alpha: 0.3),
          offset: const Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    );
  }

  /// Daha az gölgeli küçük cartoon box
  static BoxDecoration cartoonBoxSmall({
    Color color = const Color(0xFFFFE066),
    double borderWidth = 2.5,
    double radius = 14,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: darkOutline, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: darkOutline.withValues(alpha: 0.25),
          offset: const Offset(3, 3),
          blurRadius: 0,
        ),
      ],
    );
  }

  static TextStyle cartoonTitle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: darkOutline,
    letterSpacing: 1.2,
  );

  static TextStyle cartoonSubtitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: darkOutline,
  );

  static TextStyle cartoonBody = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: darkOutline,
    height: 1.4,
  );
}
