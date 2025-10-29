import 'package:flutter/material.dart';
import 'package:official_cms/admin/datatypes/datatypes.dart';

// ==============================
// COLOR THEME (Match Your App)
// ==============================
// const Color blueColor = Color(0xFF1565C0);
const Color whiteColor = Colors.white;

// ==============================
// NOTIFICATIONS PAGE
// ==============================
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Assignment Uploaded',
      'message': 'Your “Database Systems” assignment is now available.',
      'time': '2 hrs ago',
      'isRead': false,
    },
    {
      'title': 'Event Reminder',
      'message': 'Tech Fest 2025 starts tomorrow. Don’t forget to register!',
      'time': '1 day ago',
      'isRead': true,
    },
    {
      'title': 'New Message from Admin',
      'message': 'Your leave request has been approved.',
      'time': '3 days ago',
      'isRead': false,
    },
    {
      'title': 'Exam Result Published',
      'message': 'Your 5th Semester exam results are now available.',
      'time': '5 days ago',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: blueColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Notification Icon with Badge
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: whiteColor),
            tooltip: "Mark all as read",
            onPressed: () {
              setState(() {
                for (var n in notifications) {
                  n['isRead'] = true;
                }
              });
            },
          ),
        ],
      ),

      // ==============================
      // BODY
      // ==============================
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                n['isRead'] = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color:
                    n['isRead'] ? theme.cardColor : blueColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      n['isRead']
                          ? Colors.transparent
                          : blueColor.withOpacity(0.4),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    n['isRead']
                        ? Icons.notifications_none
                        : Icons.notifications_active,
                    color: n['isRead'] ? blueColor.withOpacity(0.6) : blueColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          n['title'],
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n['message'],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          n['time'],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: blueColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ActivitiesPage()),
          );
        },
        icon: const Icon(Icons.history),
        label: const Text("View Activities"),
      ),
    );
  }
}

// ==============================
// ACTIVITIES PAGE
// ==============================
class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activities = [
      {"title": "Logged in", "time": "Today, 9:30 AM"},
      {"title": "Submitted Assignment", "time": "Yesterday, 4:10 PM"},
      {"title": "Viewed Attendance", "time": "2 days ago"},
      {"title": "Changed Profile Picture", "time": "3 days ago"},
      {"title": "Updated Password", "time": "1 week ago"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
        backgroundColor: blueColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final act = activities[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: blueColor.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: blueColor.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: blueColor.withOpacity(0.15),
                child: Icon(Icons.history, color: blueColor),
              ),
              title: Text(
                act["title"]!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: blueColor,
                ),
              ),
              subtitle: Text(
                act["time"]!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: blueColor.withOpacity(0.6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
