import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:official_cms/student/student_app.dart';
import 'package:official_cms/teacher/Dashhboard/dashboard.dart';
import 'teacher/teacher_app.dart';
import 'parent/parent_app.dart';
import 'admin/admin_app.dart';

bool dark = false;

void main() {
  runApp(const MySuperApp());
}

class MySuperApp extends StatelessWidget {
  const MySuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Merged App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF4F4F9),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.auto, // 👈 label stays visible
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2.2),
          ),
          labelStyle: TextStyle(
            color: Colors.deepPurple.shade700,
            fontWeight: FontWeight.w500,
          ),
          prefixIconColor: Colors.deepPurple, // icon color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            elevation: 6,
            shadowColor: Colors.deepPurple.withOpacity(0.5),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const RoleSelector(),
    );
  }
}

class RoleSelector extends StatefulWidget {
  const RoleSelector({super.key});

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> roles = [
    {'name': 'Admin', 'icon': Icons.admin_panel_settings},
    {'name': 'Teacher', 'icon': Icons.person},
    {'name': 'Student', 'icon': Icons.school},
    {'name': 'Parent', 'icon': Icons.family_restroom},
  ];

  void _login() {
    String selectedRole = roles[currentIndex]['name'];
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter ID, password and select a role')),
      );
      return;
    }

    switch (selectedRole) {
      case 'Student':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentApp()));
        break;
      case 'Teacher':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboardpage()));
        break;
      case 'Parent':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentApp()));
        break;
      case 'Admin':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminApp()));
        break;
    }
  }

  void _nextRole() {
    setState(() {
      currentIndex = (currentIndex + 1) % roles.length;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _prevRole() {
    setState(() {
      currentIndex = (currentIndex - 1 + roles.length) % roles.length;
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please log in to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 30),

                /// 🟣 Proper bordered ID field
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.person,color: Colors.black,),
                  ),
                ),
                const SizedBox(height: 20),

                /// 🟣 Proper bordered Password field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
                  ),
                ),
                const SizedBox(height: 30),

                // 🔁 Looping role selector
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: _prevRole,
                        color: Colors.deepPurple,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 75,
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: roles.length,
                            itemBuilder: (context, index) {
                              final role = roles[index];
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      role['icon'],
                                      color: Colors.deepPurple,
                                      size: 28,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      role['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: _nextRole,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
