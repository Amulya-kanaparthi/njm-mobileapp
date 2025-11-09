import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          '🎉 You’re on the Home Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}