import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result Card',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResultCardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResultCardScreen extends StatefulWidget {
  const ResultCardScreen({super.key});

  @override
  State<ResultCardScreen> createState() => _ResultCardScreenState();
}

class _ResultCardScreenState extends State<ResultCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController symbolNoController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      symbolNoController.text = prefs.getString('symbolNo') ?? '';
      fullNameController.text = prefs.getString('fullName') ?? '';
      dobController.text = prefs.getString('dob') ?? '';
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('symbolNo', symbolNoController.text.trim());
    await prefs.setString('fullName', fullNameController.text.trim());
    await prefs.setString('dob', dobController.text.trim());
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dobController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    symbolNoController.dispose();
    fullNameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Card'),
        backgroundColor: const Color(0xFF1976D2),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.white),
            onPressed: () {
              if (isEditing) {
                if (_formKey.currentState!.validate()) {
                  _saveData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data saved locally!')),
                  );
                  setState(() {
                    isEditing = false;
                  });
                }
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Result',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: symbolNoController,
                        enabled: isEditing,
                        decoration: _inputDecoration('Symbol No'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Symbol No is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: fullNameController,
                        enabled: isEditing,
                        decoration: _inputDecoration('Full Name'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Full Name is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dobController,
                        enabled: isEditing,
                        readOnly: false,
                        onTap: isEditing ? () => _selectDate(context) : null,
                        decoration: _inputDecoration('Date of Birth').copyWith(
                          hintText: 'YYYY-MM-DD',
                          suffixIcon: isEditing ? const Icon(Icons.calendar_today) : null,
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Date of Birth is required' : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final symbolNo = symbolNoController.text.trim();
                            final fullName = fullNameController.text.trim();
                            final dob = dobController.text.trim();

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Submitted Data"),
                                content: Text(
                                  "Symbol No: $symbolNo\nFull Name: $fullName\nDate of Birth: $dob",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Find Result'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
