import 'package:flutter/material.dart';
import 'package:monitoring_siswa/models/attendance_history.dart';
import 'package:monitoring_siswa/models/student.dart';

class AttendanceProvider with ChangeNotifier {
  // Inisialisasi daftar siswa
  final List<Student> _students = [
    Student(name: 'Eric', isPresent: false),
    Student(name: 'Chipper', isPresent: false),
    Student(name: 'Zira', isPresent: false),
  ];

  // Inisialisasi daftar riwayat
  final List<AttendanceHistory> _history = [];

  // Getter untuk daftar siswa
  List<Student> get students => _students;

  // Getter untuk daftar riwayat
  List<AttendanceHistory> get history => _history;

  // Fungsi untuk menyimpan kehadiran
  void saveAttendance() {
    final presentCount = _students.where((s) => s.isPresent).length;
    final absentCount = _students.where((s) => !s.isPresent).length;

    _history.insert(
      0,
      AttendanceHistory(
        date: DateTime.now(),
        students: _students.map((s) => Student(name: s.name, isPresent: s.isPresent)).toList(),
        presentCount: presentCount,
        absentCount: absentCount,
      ),
    );

    // Reset status kehadiran siswa
    for (var student in _students) {
      student.isPresent = false;
    }

    notifyListeners();
  }

  // Fungsi untuk mengubah status kehadiran siswa
  void toggleAttendance(Student student) {
    final index = _students.indexOf(student);
    if (index != -1) {
      _students[index].isPresent = !_students[index].isPresent; // Toggle kehadiran
      notifyListeners();
    }
  }
}
