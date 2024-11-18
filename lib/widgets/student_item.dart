import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final Function(Student) onToggle;
  final Function(String, bool) onStatusChange; // Tambahkan parameter baru

  const StudentItem({
    super.key,
    required this.student,
    required this.onToggle,
    required this.onStatusChange, // Parameter tambahan
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: Checkbox(
        value: student.isPresent,
        onChanged: (value) {
          if (value != null) {
            onStatusChange(student.name, value); // Panggil fungsi status baru
          }
        },
      ),
    );
  }
}
