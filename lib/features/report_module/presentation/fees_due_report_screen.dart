import 'package:flutter/material.dart';

class FeesDueReportScreen extends StatefulWidget {
  const FeesDueReportScreen({super.key});

  @override
  State<FeesDueReportScreen> createState() => _FeesDueReportScreenState();
}

class _FeesDueReportScreenState extends State<FeesDueReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("fees due report screen")),
    );
  }
}
