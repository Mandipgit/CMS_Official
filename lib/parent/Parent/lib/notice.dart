import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Notice',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
