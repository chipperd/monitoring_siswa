import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/student_item.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final students = provider.students;

    return Scaffold(
      appBar: AppBar(title: const Text('Pencatatan Kehadiran')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, i) => StudentItem(
                student: students[i],
                onToggle: provider.toggleAttendance,
                onStatusChange: provider.updateAttendanceStatus,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: students.isEmpty
                ? null
                : () {
                    provider.saveAttendance();
                  },
            child: const Text('Simpan Kehadiran'),
          ),
        ],
      ),
    );
  }
}
