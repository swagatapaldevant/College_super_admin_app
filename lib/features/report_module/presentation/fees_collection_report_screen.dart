import 'package:flutter/material.dart';

class FeesCollectionReportScreen extends StatefulWidget {
  const FeesCollectionReportScreen({super.key});

  @override
  State<FeesCollectionReportScreen> createState() => _FeesCollectionReportScreenState();
}

class _FeesCollectionReportScreenState extends State<FeesCollectionReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("fees collection report screen")),
    );
  }
}
