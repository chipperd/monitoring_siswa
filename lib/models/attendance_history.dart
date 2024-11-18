import 'package:monitoring_siswa/models/student.dart';

class AttendanceHistory {
  final DateTime date;
  final List<Student> students;

  AttendanceHistory({
    required this.date,
    this.students = const [], required int presentCount, required int absentCount, // Default sebagai list kosong
  });
}
