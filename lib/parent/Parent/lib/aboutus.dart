import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  void _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: 'cms.support@cct.edu.np');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+9779824988806'); 
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchWebsite() async {
    final Uri url = Uri.parse('https://cct.tu.edu.np/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text("About Us", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 6, 138, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/campus.jpg'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Central Campus of Technology, CMS",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Empowering Education with Smart Digital Tools",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(height: 30),

            buildSectionTitle("Our Mission"),
            const Text(
              "To simplify and digitize all campus processes for students, faculty, and staff, ensuring efficient and transparent operations.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            buildSectionTitle("Our Vision"),
            const Text(
              "To be Nepal’s most advanced and user-friendly education management platform, driving academic excellence and innovation through smart technology.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            buildSectionTitle("Key Features"),
            buildFeature(Icons.check_circle, "Digital Leave & Attendance System"),
            buildFeature(Icons.notifications_active, "Real-time Notifications & Alerts"),
            buildFeature(Icons.calendar_today, "Class Schedules and Academic Calendar"),
            buildFeature(Icons.assignment, "Assignment & Exam Management"),
            buildFeature(Icons.admin_panel_settings, "Admin Dashboard with User Roles"),
            const SizedBox(height: 20),

            buildSectionTitle("Developed By"),
            const Text(
              "Sittal Lamichhane\nBSc.CSIT Student, 6th Semester\nCentral Campus of Technology, Tribhuvan University\nDharan, Nepal",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            buildSectionTitle("Contact"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _launchEmail,
                    child: Row(
                      children: const [
                        Icon(Icons.email, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("cms.support@cct.edu.np", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _launchPhone,
                    child: Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("+977-9824988806", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _launchWebsite,
                    child: Row(
                      children: const [
                        Icon(Icons.language, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("https://cct.tu.edu.np/", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Version 1.0.0 • © 2025 CCT",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  static Widget buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
