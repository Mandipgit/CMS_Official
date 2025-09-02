import 'package:flutter/material.dart';
import 'package:official_cms/admin/theme/theme_provider.dart';
import 'package:provider/provider.dart'; // make sure you have provider package
import 'package:official_cms/admin/navigations/body/admin_dashboard.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MaterialApp(
        title: 'Admin Section',
        home: MainNavigator(),
      ),
    );
  }
}
