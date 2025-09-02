import 'package:flutter/material.dart';
import 'package:official_cms/student/student_app.dart';
import 'package:official_cms/teacher/Dashhboard/dashboard.dart';
import 'teacher/teacher_app.dart';
import 'parent/parent_app.dart';
import 'admin/admin_app.dart';
bool dark=false;

void main() {
  runApp(const MySuperApp());
}

class MySuperApp extends StatelessWidget {
  const MySuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merged App',
      theme: ThemeData.light(),   // ✅ Default theme
      darkTheme: ThemeData.dark(), // ✅ Optional dark theme
      themeMode: ThemeMode.system, // ✅ Auto switch based on system
      home: const RoleSelector(),
    );
  }
}

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Section")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Student"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentApp()),
            ),
          ),
          
          ListTile(
            title: const Text("Teacher"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Dashboardpage()),
            ),
          ),
          ListTile(
            title: const Text("Parent"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ParentApp()),
            ),
          ),
          ListTile(
            title: const Text("Admin"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminApp()),
            ),
          ),
        ],
      ),
    );
  }
}
