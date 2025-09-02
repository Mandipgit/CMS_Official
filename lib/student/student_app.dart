import 'package:flutter/material.dart';
import 'package:official_cms/student/dashboard/dashboard.dart';
// your main screen

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Section',
      home: Dashboard(),  // your old home screen
);
}
}