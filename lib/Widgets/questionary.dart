import 'package:cognicare/constants/text.dart';
import 'package:flutter/material.dart';

class Questionary_widget extends StatefulWidget {
  final String question;
  final int no;
  final int type;
  final TextEditingController controller;
  const Questionary_widget(
      {required this.question,
      required this.no,
      required this.type,
      required this.controller,
      super.key});

  @override
  State<Questionary_widget> createState() => _Questionary_widgetState();
}

class _Questionary_widgetState extends State<Questionary_widget> {
  String question = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // For the questions with options.
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 236,
              height: 380,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 250, 255, 0.5),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 276,
              height: 367,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 250, 255, 0.9),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 305,
              height: 353,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 250, 255, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: widget.no / 16,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${widget.no} of 16",
                          style: knormalTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.question,
                          style: knormalTextStyle.copyWith(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    widget.type == 0 //0 - text input //1 - options
                        ? Container(
                            height: 135,
                            width: 265,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF6FAFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFFD5D5D5),
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: widget.controller,
                              maxLines: null, // allows multiple lines
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "Enter your text here...",
                                border: InputBorder
                                    .none, // removes default underline
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : Text(
                            widget.type == 1
                                ? "Select any one option below either thumbs up (yes) or thumbs down (no)."
                                : "",
                            style: knormalTextStyle.copyWith(
                                color: Color.fromRGBO(132, 132, 132, 1),
                                fontSize: 12),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
