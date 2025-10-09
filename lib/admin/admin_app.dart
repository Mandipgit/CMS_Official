import 'package:flutter/material.dart';
import 'package:official_cms/admin/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:official_cms/admin/navigations/body/admin_dashboard.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Admin Section',
            theme: themeProvider.currentTheme,
            home: MainNavigator(),
          );
        },
      ),
    );
  }
}
