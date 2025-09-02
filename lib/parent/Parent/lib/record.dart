import 'package:flutter/material.dart';

class Subject {
  final String name;
  final double grade;
  final List<TestScore> testScores;
  final List<Assignment> assignments;

  const Subject({
    required this.name,
    required this.grade,
    required this.testScores,
    required this.assignments,
  });
}

class TestScore {
  final String title;
  final double score;

  const TestScore({required this.title, required this.score});
}

class Assignment {
  final String title;
  final bool submitted;

  const Assignment({required this.title, required this.submitted});
}

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  final String studentName = "Mandip Lamichhane";

  final List<Subject> subjects = const [
    Subject(
      name: "Mathematics",
      grade: 85.5,
      testScores: [
        TestScore(title: "Unit Test 1", score: 80),
        TestScore(title: "Final Exam", score: 91),
      ],
      assignments: [
        Assignment(title: "Assignment 1", submitted: true),
        Assignment(title: "Assignment 2", submitted: false),
      ],
    ),
    Subject(
      name: "Science",
      grade: 90.0,
      testScores: [
        TestScore(title: "Lab Test", score: 88),
        TestScore(title: "Final Exam", score: 92),
      ],
      assignments: [
        Assignment(title: "Lab Report", submitted: true),
        Assignment(title: "Field Survey", submitted: true),
      ],
    ),
    Subject(
      name: "English",
      grade: 82.0,
      testScores: [
        TestScore(title: "Grammar Test", score: 78),
        TestScore(title: "Literature Final", score: 86),
      ],
      assignments: [
        Assignment(title: "Essay Writing", submitted: true),
        Assignment(title: "Book Report", submitted: true),
      ],
    ),
    Subject(
      name: "Computer",
      grade: 95.0,
      testScores: [
        TestScore(title: "Practical Test", score: 97),
        TestScore(title: "Theory Final", score: 93),
      ],
      assignments: [
        Assignment(title: "Coding Assignment", submitted: true),
        Assignment(title: "Presentation", submitted: false),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
           color: Colors.blue.shade300,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student: $studentName",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Subjects",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(subject.name),
                    subtitle: Text("Grade: ${subject.grade.toStringAsFixed(1)}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SubjectDetailsPage(subject: subject),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectDetailsPage extends StatelessWidget {
  final Subject subject;
  const SubjectDetailsPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${subject.name} Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                title: const Text("Overall Grade"),
                subtitle: Text(
                  "${subject.grade.toStringAsFixed(1)} / 100",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(" Test Scores",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...subject.testScores.map(
              (test) => Card(
                elevation: 2,
                child: ListTile(
                  title: Text(test.title),
                  trailing: Text("${test.score.toStringAsFixed(1)} / 100"),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(" Assignments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...subject.assignments.map(
              (assignment) => Card(
                elevation: 2,
                child: ListTile(
                  title: Text(assignment.title),
                  trailing: Icon(
                    assignment.submitted ? Icons.check_circle : Icons.cancel,
                    color: assignment.submitted ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
