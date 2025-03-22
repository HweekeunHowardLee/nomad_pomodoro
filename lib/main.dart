import 'package:flutter/material.dart';
import 'package:stateful_widget/screens/home_screen.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontStyle: FontStyle.normal,
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}
