import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/attendance_history.dart';

class AttendanceProvider with ChangeNotifier {
  final List<Student> _students = [
    Student(name: 'eric'),
    Student(name: 'chipper'),
    Student(name: 'zira'),
  ];

  final List<AttendanceHistory> _history = [];

  List<Student> get students => _students;

  List<AttendanceHistory> get history => _history;

  void toggleAttendance(Student student) {
    student.isPresent = !student.isPresent;
    notifyListeners();
  }

  void updateAttendanceStatus(String name, bool isPresent) {
    final student = _students.firstWhere((student) => student.name == name);
    student.isPresent = isPresent;
    notifyListeners();
  }

  void saveAttendance() {
    final presentCount = _students.where((student) => student.isPresent).length;
    final absentCount = _students.length - presentCount;

    _history.insert(
      0,
      AttendanceHistory(
        date: DateTime.now(),
        presentCount: presentCount,
        absentCount: absentCount,
      ),
    );

    for (var student in _students) {
      student.isPresent = false;
    }

    notifyListeners();
  }
}
