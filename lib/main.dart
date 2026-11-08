import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const WizardingArchives());
}

class WizardingArchives extends StatelessWidget {
  const WizardingArchives({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Wizarding Archives',
      theme: ThemeData(
        fontFamily: 'Georgia',
        brightness: Brightness.dark,
      ),
      home: const LoginScreen(),
    );
  }
}