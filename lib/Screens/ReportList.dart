import 'package:cognicare/Bloc/reportGen/bloc/report_gen_bloc.dart';
import 'package:cognicare/Screens/Report.dart';
import 'package:cognicare/Widgets/reportWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  // Sample report data (you can replace with your dynamic list)
  // final List<Map<String, String>> reports = [
  //   {'name': 'Sabari Krishnan', 'date': '14.08.2025'},
  //   {'name': 'Tarun Sakthivel', 'date': '13.08.2025'},
  //   {'name': 'Ananya Ravi', 'date': '12.08.2025'},
  //   {'name': 'Dev', 'date': '11.08.2025'},
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportGenBloc, ReportGenState>(
      builder: (context, state) {
        if (state is FetchLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is FetchFailure) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Center(
              child: Text("Error: ${state.errorMessage}"),
            ),
          );
        }
        if (state is FetchSuccess) {
          // You can handle the successful state if needed
          final reports = state.reports;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Report List',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemCount: reports.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final report = reports[index];
                  final date = report.timestamp.split('T').first;
                  final confidence =
                      report.confidenceProbability.toStringAsFixed(2);

                  return ReportWidget(
                    name: "Report ${report.id} ",
                    date:
                        "Date: $date • Confidence: ${report.combinedProbability.toStringAsFixed(2)}%",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportDetailPage(
                            report: report, // ✅ Pass model to detail page
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Report List',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text("No reports available."),
            ),
          ),
        );
      },
    );
  }
}
