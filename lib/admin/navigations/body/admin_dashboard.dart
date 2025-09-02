import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Replace these imports with your actual files
import 'package:official_cms/admin/datatypes/datatypes.dart';
import 'package:official_cms/admin/navigations/navbar/admin_navbar.dart';
import 'package:official_cms/admin/navigations/screens/admin/adminPannel/adminPannel.dart';
import 'package:official_cms/admin/navigations/screens/admit-card-generator/admitcardgenerator.dart';
import 'package:official_cms/admin/navigations/screens/approve/leave-request/leave-request-approve.dart';
import 'package:official_cms/admin/navigations/screens/examination/resultpage.dart';
import 'package:official_cms/admin/navigations/screens/id-card-generator/idcardgenerator.dart';
import 'package:official_cms/admin/navigations/screens/notifications/notification.dart';
import 'package:official_cms/admin/navigations/screens/profile/profile.dart';
import 'package:official_cms/admin/navigations/screens/student/student.dart';
import 'package:official_cms/admin/navigations/screens/teacher/teacher.dart';
import 'package:official_cms/admin/theme/theme_provider.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Admin Section',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            home: const MainNavigator(),
          );
        },
      ),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showingDashboard = true;

  void _pushPage(Widget page) {
    setState(() => _showingDashboard = false);
    _navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => page))
        .then((_) => setState(() => _showingDashboard = true));
  }

  Future<bool> _onWillPop() async {
    if (!_showingDashboard) {
      if (_navigatorKey.currentState?.canPop() ?? false) {
        _navigatorKey.currentState?.pop();
        return false;
      }
      setState(() => _showingDashboard = true);
      return false;
    }

    bool shouldExit = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ),
        ) ??
        false;

    if (shouldExit) SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _showingDashboard ? Navbar() : null,
        appBar: _showingDashboard
            ? AppBar(
                backgroundColor: blueColor,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                title: const Text('Admin'),
                actions: [
                  IconButton(
                    icon: Icon(themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () => _pushPage(SendNotificationPage()),
                  ),
                ],
              )
            : null,
        body: Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => Dashboard(onSectionSelected: _pushPage),
              ),
            ),
            if (_showingDashboard)
              Positioned(
                right: 60,
                bottom: 60,
                child: FloatingActionButton(
                  onPressed: () => _pushPage(ThemeSelector()),
                  backgroundColor: blueColor,
                  child: const Icon(Icons.color_lens, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ----------------------------------------
/// Dashboard Widget
/// ----------------------------------------
class Dashboard extends StatefulWidget {
  final Function(Widget) onSectionSelected;

  const Dashboard({super.key, required this.onSectionSelected});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Key _refreshKey = UniqueKey();

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _refreshKey = UniqueKey());

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Dashboard refreshed')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                OverVeiw(
                  key: _refreshKey,
                  onSectionSelected: widget.onSectionSelected,
                ),
                const SizedBox(height: 20),
                Gridbuild(onSectionSelected: widget.onSectionSelected),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------
/// Overview Widget
/// ----------------------------------------
class OverVeiw extends StatefulWidget {
  final Function(Widget) onSectionSelected;

  const OverVeiw({super.key, required this.onSectionSelected});

  @override
  State<OverVeiw> createState() => _OverVeiwState();
}

class _OverVeiwState extends State<OverVeiw> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        color: blueColor,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => widget.onSectionSelected(ProfileScreen()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            "Amit Mahato | Dean",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/img1profile.jpg",
                            fit: BoxFit.cover,
                            width: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const ViewCount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------
/// ViewCount Widget
/// ----------------------------------------
class ViewCount extends StatefulWidget {
  const ViewCount({super.key});

  @override
  State<ViewCount> createState() => _ViewCountState();
}

class _ViewCountState extends State<ViewCount> {
  final List<Map<String, dynamic>> countMap = [
    {"number": "68", "Title": "Teachers", "icon": Icons.person_outline},
    {"number": "1108", "Title": "Students", "icon": Icons.school_outlined},
    {"number": "16", "Title": "Admin's", "icon": Icons.admin_panel_settings_outlined},
    {"number": "969", "Title": "Parents", "icon": Icons.people_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return SizedBox(
        height: 105,
        width: screenWidth - 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: countMap.map((data) {
            final int targetNumber = int.parse(data["number"]);
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: targetNumber.toDouble()),
              duration: const Duration(seconds: 4),
              builder: (context, value, child) {
                return Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomPaint(
                          painter: CircleProgressPainter(
                              progress: value / targetNumber, color: blueColor),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                  Icon(data["icon"], size: 16, color: blueColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            data["Title"],
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CircleProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 3.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;

    final backgroundPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// ----------------------------------------
/// Gridbuild Widget
/// ----------------------------------------
class Gridbuild extends StatefulWidget {
  final Function(Widget) onSectionSelected;

  const Gridbuild({super.key, required this.onSectionSelected});

  @override
  State<Gridbuild> createState() => _GridbuildState();
}

class _GridbuildState extends State<Gridbuild> {
  final List<Map<String, dynamic>> gridMap = [
    {"icon": "assets/icons/parent.png", "title": "Admin Pannel", "description": "Manage and monitor user accounts, roles."},
    {"icon": "assets/icons/icons2-teacher.png", "title": "Teacher", "description": "Manage teacher profiles and assignments"},
    {"icon": "assets/icons/icons3-students.png", "title": "Students", "description": "Manage student profiles and academic records"},
    {"icon": "assets/icons/icon6-form.png", "title": "Admit Card", "description": "Generates Admit Card for Students"},
    {"icon": "assets/icons/icons4-approve.png", "title": "Approve", "description": "Review and approve leave requests"},
    {"icon": "assets/icons/examination.png", "title": "Result", "description": "Manage exams, results and grade reports"},
    {"icon": "assets/icons/examination.png", "title": "ID Card", "description": "Generates ID card of students"},
    {"icon": "assets/icons/icon7-notification.png", "title": "Notifications", "description": "Send and manage important announcements"},
  ];

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final int itemToShow = _isExpanded ? gridMap.length : 6;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Campus Services",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemToShow,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 210,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      final String title = gridMap[index]["title"];
                      final Map<String, Widget> screenMap = {
                        "Students": NewStudent(),
                        "Admin Pannel": UserManagementScreen(),
                        "Teacher": TeacherScreen(),
                        "Admit Card": AdmitCardGenerator(),
                        "Notifications": SendNotificationPage(),
                        "Approve": LeaveRequestApprove(),
                        "Result": ResultPage(),
                        "ID Card": IDCardGenerator(),
                      };
                      if (screenMap.containsKey(title)) {
                        widget.onSectionSelected(screenMap[title]!);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: blueColor.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: blueColor.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                gridMap[index]['icon'],
                                height: 70,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gridMap[index]['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  gridMap[index]['description'],
                                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
        if (gridMap.length > 6)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              style: TextButton.styleFrom(
                backgroundColor: blueColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? "Show Less" : "Show More",
                    style: TextStyle(
                        color: blueColor, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: blueColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
