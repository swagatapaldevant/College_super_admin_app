import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Attendance report screen")),
    );
  }
}

