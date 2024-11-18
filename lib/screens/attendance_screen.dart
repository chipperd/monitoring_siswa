import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  // Fungsi untuk menampilkan popup "Data Tersimpan"
  void _showSavedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Berhasil'),
        content: const Text('Data kehadiran telah tersimpan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Menutup popup
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final students = provider.students;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Kehadiran'),
      ),
      body: Column(
        children: [
          Expanded(
            child: students.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada data siswa.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(students[i].name),
                      trailing: Checkbox(
                        value: students[i].isPresent,
                        onChanged: (value) {
                          provider.toggleAttendance(students[i]);
                        },
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: students.isEmpty
                  ? null
                  : () {
                      provider.saveAttendance(); // Simpan data
                      _showSavedPopup(context); // Tampilkan popup
                    },
              child: const Text('Simpan Kehadiran'),
            ),
          ),
        ],
      ),
    );
  }
}
