import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance & Performance',
      debugShowCheckedModeBanner: false,
      home: const PerformanceScreen(),
    );
  }
}

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  late Map<DateTime, String> _attendanceRecords;
  late Map<DateTime, Map<String, int>> _performanceRecords;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> _statusOptions = ['Present at time', 'Absent', 'Late', 'Holiday'];
  final List<String> _subjects = ['Math', 'Science', 'English', 'Computer'];

  @override
  void initState() {
    super.initState();
    _attendanceRecords = _generateMockAttendance();
    _performanceRecords = _generateMockPerformance();
    _selectedDay = _focusedDay;
  }

  Map<DateTime, String> _generateMockAttendance() {
    final Map<DateTime, String> data = {};
    final today = DateTime.now();
    final start = DateTime(today.year - 1, today.month, today.day);
    final random = Random();

    for (int i = 0; i <= 365; i++) {
      final date = start.add(Duration(days: i));
      if (date.weekday == DateTime.saturday) {
        data[date] = 'Holiday';
      } else {
        data[date] = _statusOptions[random.nextInt(3)];
      }
    }
    return data;
  }

  Map<DateTime, Map<String, int>> _generateMockPerformance() {
    final Map<DateTime, Map<String, int>> data = {};
    final today = DateTime.now();
    final start = DateTime(today.year - 1, today.month, today.day);
    final random = Random();

    for (int i = 0; i <= 365; i++) {
      final date = start.add(Duration(days: i));
      final status = _attendanceRecords[date];

      if (date.weekday != DateTime.saturday) {
        if (status == 'Absent') {
          data[date] = {
            for (var subject in _subjects) subject: 0
          };
        } else {
          data[date] = {
            for (var subject in _subjects) subject: 60 + random.nextInt(41)
          };
        }
      }
    }

    return data;
  }

  String _getStatus(DateTime day) {
    return _attendanceRecords[DateTime(day.year, day.month, day.day)] ?? 'No Data';
  }

  Map<String, int> _getPerformance(DateTime day) {
    return _performanceRecords[DateTime(day.year, day.month, day.day)] ?? {};
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present at time':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.orange;
      case 'Holiday':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Map<String, int> _getMonthlySummary(DateTime month) {
    int present = 0, absent = 0, late = 0, holiday = 0;

    _attendanceRecords.forEach((date, status) {
      if (date.year == month.year && date.month == month.month) {
        switch (status) {
          case 'Present at time':
            present++;
            break;
          case 'Absent':
            absent++;
            break;
          case 'Late':
            late++;
            break;
          case 'Holiday':
            holiday++;
            break;
        }
      }
    });

    return {
      'Present at time': present,
      'Absent': absent,
      'Late': late,
      'Holiday': holiday,
      'TotalEffectivePresent': present + late,
    };
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = _selectedDay ?? DateTime.now();
    final attendanceStatus = _getStatus(selectedDate);
    final performance = _getPerformance(selectedDate);
    final summary = _getMonthlySummary(_focusedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance & Performance'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now(),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final status = _getStatus(day);
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getStatusColor(status),
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Attendance: $attendanceStatus',
              style: TextStyle(
                fontSize: 20,
                color: _getStatusColor(attendanceStatus),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            performance.isNotEmpty
                ? Column(
                    children: performance.entries.map((entry) {
                      return Text(
                        '${entry.key}: ${entry.value}%',
                        style: const TextStyle(fontSize: 16),
                      );
                    }).toList(),
                  )
                : const Text(
                    'No Performance Data',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const Text(
              'Monthly Attendance Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Present at time: ${summary['Present at time']}', style: const TextStyle(fontSize: 16)),
            Text('Late: ${summary['Late']}', style: const TextStyle(fontSize: 16)),
            Text('Absent: ${summary['Absent']}', style: const TextStyle(fontSize: 16)),
            Text('Holiday: ${summary['Holiday']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Total Effective Present: ${summary['TotalEffectivePresent']}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
