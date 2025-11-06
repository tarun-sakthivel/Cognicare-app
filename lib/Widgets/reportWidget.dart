import 'package:flutter/material.dart';

class Reportwidget extends StatefulWidget {
  const Reportwidget({super.key});

  @override
  State<Reportwidget> createState() => _ReportwidgetState();
}

class _ReportwidgetState extends State<Reportwidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2A4D99),
              Color(0xFF4680FF),
            ], // change as needed
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      Positioned(
        right: 10,
        bottom: 15,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.arrow_outward,
            color: Colors.white,
          ),
        ),
      ),
      const Positioned(
        left: 20,
        bottom: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sabari Krishnan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "14.08.2025",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
