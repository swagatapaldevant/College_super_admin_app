import 'package:flutter/material.dart';

class TransactionReportScreen extends StatefulWidget {
  const TransactionReportScreen({super.key});

  @override
  State<TransactionReportScreen> createState() => _TransactionReportScreenState();
}

class _TransactionReportScreenState extends State<TransactionReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("transaction report screen")),
    );
  }
}
