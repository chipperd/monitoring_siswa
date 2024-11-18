import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Fungsi untuk mencetak riwayat data ke console
  void _printHistoryData(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);
    final history = provider.history;

    for (var record in history) {
      debugPrint('Tanggal: ${record.date}');
      if (record.students.isEmpty) {
        debugPrint('Students list is null or empty!');
      } else {
        for (var student in record.students) {
          debugPrint(
            'Nama: ${student.name}, Kehadiran: ${student.isPresent ? 'Hadir' : 'Tidak Hadir'}',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    final history = provider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kehadiran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () =>
                _printHistoryData(context), // Cetak data ke console
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Text('Belum ada riwayat kehadiran.'),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (ctx, i) {
                final record = history[i];
                final presentStudents =
                    record.students.where((s) => s.isPresent).toList();
                final absentStudents =
                    record.students.where((s) => !s.isPresent).toList();

                return ExpansionTile(
                  title: Text(
                      'Tanggal: ${record.date.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text(
                    'Hadir: ${presentStudents.length}, Tidak Hadir: ${absentStudents.length}',
                  ),
                  children: [
                    if (presentStudents.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hadir:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ...presentStudents.map((student) => ListTile(
                                  title: Text(student.name),
                                  leading: const Icon(Icons.check_circle,
                                      color: Colors.green),
                                )),
                          ],
                        ),
                      ),
                    if (absentStudents.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tidak Hadir:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ...absentStudents.map((student) => ListTile(
                                  title: Text(student.name),
                                  leading: const Icon(Icons.cancel,
                                      color: Colors.red),
                                )),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
