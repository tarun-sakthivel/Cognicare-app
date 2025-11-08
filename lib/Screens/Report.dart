import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportDetailPage extends StatelessWidget {
  final String name;
  final String date;

  const ReportDetailPage({
    super.key,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$name’s Report",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 15.0),
        //     child: Icon(Icons.picture_as_pdf, color: Colors.black),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assessment Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Assessment:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAssessmentItem(
                        icon: Icons.assignment,
                        label: "Questionary",
                        activeCount: 4,
                        color: Colors.red,
                      ),
                      _buildAssessmentItem(
                        icon: Icons.visibility,
                        label: "Eye Contact",
                        activeCount: 2,
                        color: Colors.grey,
                      ),
                      _buildAssessmentItem(
                        icon: Icons.psychology,
                        label: "AI Analysis",
                        activeCount: 3,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Risk Level
            const Text(
              "Risk Level:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 12.0,
                percent: 0.85,
                center: const Text(
                  "High",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.redAccent,
                backgroundColor: Colors.grey.shade200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(height: 25),

            // Result Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Our analysis shows that your child may have some early signs linked to autism. "
                "This does not confirm a diagnosis, but we recommend consulting a pediatrician "
                "or specialist for further guidance. Early support can make a big difference, "
                "and you’re already taking the right step by checking.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "@ CogniCare Team 2025",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for assessment row
  Widget _buildAssessmentItem({
    required IconData icon,
    required String label,
    required int activeCount,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.black, size: 24),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(
                Icons.square_rounded,
                size: 12,
                color: index < activeCount ? color : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
