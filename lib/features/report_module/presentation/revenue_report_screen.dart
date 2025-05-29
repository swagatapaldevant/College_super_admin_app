import 'package:flutter/material.dart';

class RevenueReportScreen extends StatefulWidget {
  const RevenueReportScreen({super.key});

  @override
  State<RevenueReportScreen> createState() => _RevenueReportScreenState();
}

class _RevenueReportScreenState extends State<RevenueReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Revenue report screen")),
    );
  }
}
