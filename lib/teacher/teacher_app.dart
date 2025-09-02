import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:official_cms/teacher/Dashhboard/dashboard.dart';
import 'package:official_cms/teacher/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        // Use builder so the context inside TeacherApp can access ThemeProvider
        builder: (context, child) {
          return const TeacherApp();
        },
      ),
    );
  });
}

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const mainPage(),
      theme: context.watch<ThemeProvider>().themedata, // works correctly now
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return const Dashboardpage();
  }
}
