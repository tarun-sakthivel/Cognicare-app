import 'package:cognicare/Widgets/reportWidget.dart';
import 'package:flutter/material.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  // Sample report data (you can replace with your dynamic list)
  final List<Map<String, String>> reports = [
    {'name': 'Sabari Krishnan', 'date': '14.08.2025'},
    {'name': 'Tarun Sakthivel', 'date': '13.08.2025'},
    {'name': 'Ananya Ravi', 'date': '12.08.2025'},
    {'name': 'Dev', 'date': '11.08.2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report List',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: reports.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final report = reports[index];
            return ReportWidget(
              name: report['name']!,
              date: report['date']!,
              onTap: () {
                // Handle navigation to details or report page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Opening report of ${report['name']}")),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
