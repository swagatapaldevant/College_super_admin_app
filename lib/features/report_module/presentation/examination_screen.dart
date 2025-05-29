import 'package:flutter/material.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("examination report screen")),
    );
  }
}
