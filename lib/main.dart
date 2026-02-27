import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'theme/cartoon_theme.dart';

void main() {
  runApp(const CartoonNotesApp());
}

class CartoonNotesApp extends StatelessWidget {
  const CartoonNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartoon Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CartoonTheme.accentPink,
          surface: CartoonTheme.bgColor,
        ),
        textTheme: GoogleFonts.balooBhai2TextTheme(),
        scaffoldBackgroundColor: CartoonTheme.bgColor,
      ),
      home: const HomeScreen(),
    );
  }
}
