import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as badges;
import 'package:official_cms/admin/navigations/navbar/admin_navbar.dart';
import 'package:official_cms/student/Navigationtools/navbar.dart';
import 'package:official_cms/student/allvariables/allVar.dart';
import 'package:official_cms/student/extravar/gridbox.dart';
import 'package:official_cms/student/pages/Profilepage/profilePage.dart';
import 'package:official_cms/student/pages/notification.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


bool dark = false;
List<String> notifications = [
  'Class postponed',
  'New assignment uploaded',
  'Exam schedule updated'
];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var percentage = 90;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Notifications': (context) => const NotificationPage(),
      },
      home: Builder(
        builder: (context) => Scaffold(
          drawer: const Navvbar(),
          appBar: AppBar(
            backgroundColor: primaryBlue,
            elevation: 6,
            shadowColor: Colors.deepPurpleAccent,
            centerTitle: true,
            title: const Text(
              'Student Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 1.1,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: badges.Badge(
                  isLabelVisible: notifications.isNotEmpty,
                  label: Text('${notifications.length}'),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            dark = !dark;
                          });
                        },
                        icon: Icon(
                          dark ? Icons.light_mode : Icons.dark_mode,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('Notifications');
                        },
                        icon: const Icon(
                          Icons.notifications,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 📄 Body of the Dashboard
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // 🔷 Header Card
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, top: 20, left: 30, right: 30),
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Hello Sushant',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Bsc.CSIT | 5th Semester | Rollno : 09',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyProfile()));
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 28,
                                    backgroundColor: Colors.white24,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/stuprofile.png',
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'Attendance: $percentage%',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.78,
                                    child: LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 2000,
                                      lineHeight: 22,
                                      percent: percentage / 100,
                                      curve: Curves.easeIn,
                                      progressColor:
                                          Colors.lightGreenAccent[400],
                                      backgroundColor:
                                          Colors.deepPurple[200],
                                      barRadius: const Radius.circular(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 📌 Explore Categories title
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 16, right: 16),
                  child: SizedBox(
                    height: 34,
                    child: Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple[800],
                      ),
                    ),
                  ),
                ),

                // 🧩 GridBox Section
                GridBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
