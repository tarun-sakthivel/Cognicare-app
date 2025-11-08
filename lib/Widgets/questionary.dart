// import 'package:cognicare/constants/text.dart';
// import 'package:flutter/material.dart';

// class Questionary_widget extends StatefulWidget {
//   final String question;
//   final int no;
//   final int type;
//   final TextEditingController controller;
//   final Function(String)? onAnswerSelected;
//   const Questionary_widget(
//       {required this.question,
//       required this.no,
//       required this.type,
//       required this.controller,
//       this.onAnswerSelected,
//       super.key});

//   @override
//   State<Questionary_widget> createState() => _Questionary_widgetState();
// }

// class _Questionary_widgetState extends State<Questionary_widget> {
//   String question = "";
//   double progress = 0;
//   int ageInMonths = 0;
//   String? dropdownValue;
//   void _increment() {
//     setState(() {
//       ageInMonths++;
//     });
//   }

//   void _decrement() {
//     setState(() {
//       if (ageInMonths > 0) ageInMonths--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // For the questions with options.
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 236,
//               height: 380,
//               decoration: BoxDecoration(
//                   color: Color.fromRGBO(246, 250, 255, 0.5),
//                   borderRadius: BorderRadius.circular(15)),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 276,
//               height: 367,
//               decoration: BoxDecoration(
//                   color: Color.fromRGBO(246, 250, 255, 0.9),
//                   borderRadius: BorderRadius.circular(15)),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 305,
//               height: 353,
//               decoration: BoxDecoration(
//                   color: Color.fromRGBO(246, 250, 255, 1),
//                   borderRadius: BorderRadius.circular(15)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     LinearProgressIndicator(
//                       value: widget.no / 16,
//                       minHeight: 8,
//                       borderRadius: BorderRadius.circular(8),
//                       backgroundColor: Colors.grey[300],
//                       valueColor:
//                           const AlwaysStoppedAnimation<Color>(Colors.blue),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Question ${widget.no} of 16",
//                           style: knormalTextStyle.copyWith(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           widget.question,
//                           style: knormalTextStyle.copyWith(
//                               fontSize: 28, fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                     if (widget.type == 0) //0 - text input //1 - options
//                       Container(
//                         height: 135,
//                         width: 265,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Color(0xFFF6FAFF),
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: Color(0xFFD5D5D5),
//                             width: 1,
//                           ),
//                         ),
//                         child: TextField(
//                           controller: widget.controller,
//                           maxLines: null, // allows multiple lines
//                           keyboardType: TextInputType.multiline,
//                           decoration: const InputDecoration(
//                             hintText: "Enter your text here...",
//                             border:
//                                 InputBorder.none, // removes default underline
//                           ),
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       )
//                     else if (widget.type == 1 || widget.type == 6)
//                       Text(
//                         widget.type == 1 || widget.type == 6
//                             ? "Select any one option below either thumbs up (yes) or thumbs down (no)."
//                             : "",
//                         style: knormalTextStyle.copyWith(
//                             color: Color.fromRGBO(132, 132, 132, 1),
//                             fontSize: 12),
//                       )
//                     // else if (widget.type == 3)
//                     //   Row(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [
//                     //       IconButton(
//                     //         onPressed: _decrement,
//                     //         icon: const Icon(Icons.remove_circle,
//                     //             color: Color.fromARGB(255, 0, 0, 0), size: 32),
//                     //       ),
//                     //       Padding(
//                     //         padding: const EdgeInsets.symmetric(horizontal: 16),
//                     //         child: Text(
//                     //           '$ageInMonths months',
//                     //           style: const TextStyle(
//                     //               fontSize: 20, fontWeight: FontWeight.w600),
//                     //         ),
//                     //       ),
//                     //       IconButton(
//                     //         onPressed: _increment,
//                     //         icon: const Icon(Icons.add_circle,
//                     //             color: Color.fromARGB(255, 0, 0, 0), size: 32),
//                     //       ),
//                     //     ],
//                     //   )
//                     else if (widget.type == 3)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               if (ageInMonths > 0) {
//                                 setState(() => ageInMonths--);
//                                 widget.onAnswerSelected
//                                     ?.call(ageInMonths.toString());
//                               }
//                             },
//                             icon: const Icon(Icons.remove_circle,
//                                 color: Colors.black, size: 32),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Text(
//                               '$ageInMonths months',
//                               style: const TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() => ageInMonths++);
//                               widget.onAnswerSelected
//                                   ?.call(ageInMonths.toString());
//                             },
//                             icon: const Icon(Icons.add_circle,
//                                 color: Colors.black, size: 32),
//                           ),
//                         ],
//                       )

//                     // --- Type 5 : Dropdown with 5 options ---
//                     else if (widget.type == 5)
//                       DropdownButton<String>(
//                         value: dropdownValue,
//                         hint: const Text("Select an option"),
//                         items: const [
//                           DropdownMenuItem(
//                               value: "Asian", child: Text("Asian")),
//                           DropdownMenuItem(
//                               value: "Nigerians", child: Text("Nigerians")),
//                           DropdownMenuItem(
//                               value: "South american",
//                               child: Text("South american")),
//                           DropdownMenuItem(
//                               value: "North american",
//                               child: Text("Norht american")),
//                           DropdownMenuItem(
//                               value: "Latina", child: Text("Latina")),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             dropdownValue = value!;
//                           });
//                           widget.onAnswerSelected?.call(value!);
//                         },
//                       )
//                     else if (widget.type == 4)
//                       DropdownButton<String>(
//                         value: dropdownValue,
//                         hint: const Text("Select an option"),
//                         items: const [
//                           DropdownMenuItem(value: "m", child: Text("m")),
//                           DropdownMenuItem(value: "f", child: Text("f")),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             dropdownValue = value;
//                           });
//                           if (value != null)
//                             widget.onAnswerSelected?.call(value);
//                         },
//                       )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cognicare/constants/text.dart';
import 'package:flutter/material.dart';

class Questionary_widget extends StatefulWidget {
  final String question;
  final int no;
  final int type;
  final TextEditingController controller;
  final Function(String)? onAnswerSelected;

  const Questionary_widget({
    required this.question,
    required this.no,
    required this.type,
    required this.controller,
    this.onAnswerSelected,
    super.key,
  });

  @override
  State<Questionary_widget> createState() => _Questionary_widgetState();
}

class _Questionary_widgetState extends State<Questionary_widget> {
  int ageInMonths = 0;

  // Separate values for different dropdowns to avoid conflicts
  String? genderValue;
  String? ethnicityValue;

  // allowed option lists (kept here to use for validation)
  static const List<String> _genderOptions = ['m', 'f'];
  static const List<String> _ethnicityOptions = [
    'Asian',
    'Nigerians',
    'South american',
    'North american',
    'Latina'
  ];

  @override
  void didUpdateWidget(covariant Questionary_widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the question type changed, ensure we don't keep invalid dropdown value
    if (oldWidget.type != widget.type) {
      if (widget.type == 4) {
        // gender dropdown now — clear ethnicity if it was previously set
        ethnicityValue = null;
        // ensure genderValue is valid
        if (genderValue != null && !_genderOptions.contains(genderValue)) {
          genderValue = null;
        }
      } else if (widget.type == 5) {
        // ethnicity dropdown now — clear gender if it was previously set
        genderValue = null;
        if (ethnicityValue != null && !_ethnicityOptions.contains(ethnicityValue)) {
          ethnicityValue = null;
        }
      } else {
        // for other types clear both dropdowns to be safe
        genderValue = null;
        ethnicityValue = null;
      }
    }
  }

  void _increment() {
    setState(() {
      ageInMonths++;
    });
    widget.onAnswerSelected?.call(ageInMonths.toString());
  }

  void _decrement() {
    if (ageInMonths > 0) {
      setState(() {
        ageInMonths--;
      });
      widget.onAnswerSelected?.call(ageInMonths.toString());
    }
  }

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
                color: const Color.fromRGBO(246, 250, 255, 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 276,
              height: 367,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 250, 255, 0.9),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 305,
              height: 353,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 250, 255, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: (widget.no / 16).clamp(0.0, 1.0),
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
                        const SizedBox(height: 10),
                        Text(
                          widget.question,
                          style: knormalTextStyle.copyWith(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),

                    // === TYPE 0: Text Input ===
                    if (widget.type == 0)
                      Container(
                        height: 135,
                        width: 265,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6FAFF),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFFD5D5D5),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: widget.controller,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: "Enter your text here...",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 16),
                          onChanged: (val) {
                            widget.onAnswerSelected?.call(val);
                          },
                        ),
                      )

                    // === TYPE 1 or 6: Thumbs up / down instruction ===
                    else if (widget.type == 1 || widget.type == 6)
                      Text(
                        "Select any one option below either thumbs up (yes) or thumbs down (no).",
                        style: knormalTextStyle.copyWith(
                          color: const Color.fromRGBO(132, 132, 132, 1),
                          fontSize: 12,
                        ),
                      )

                    // === TYPE 3: Age in months incrementer ===
                    else if (widget.type == 3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _decrement,
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.black, size: 32),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '$ageInMonths months',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          IconButton(
                            onPressed: _increment,
                            icon: const Icon(Icons.add_circle,
                                color: Colors.black, size: 32),
                          ),
                        ],
                      )

                    // === TYPE 5: Ethnicity Dropdown ===
                    else if (widget.type == 5)
                      Builder(builder: (context) {
                        // ensure current ethnicityValue is valid for this dropdown
                        if (ethnicityValue != null &&
                            !_ethnicityOptions.contains(ethnicityValue)) {
                          ethnicityValue = null;
                        }

                        return DropdownButton<String>(
                          value: ethnicityValue,
                          hint: const Text("Select ethnicity"),
                          items: _ethnicityOptions
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => ethnicityValue = value);
                            if (value != null) widget.onAnswerSelected?.call(value);
                          },
                        );
                      })

                    // === TYPE 4: Gender Dropdown ===
                    else if (widget.type == 4)
                      Builder(builder: (context) {
                        // ensure current genderValue is valid for this dropdown
                        if (genderValue != null &&
                            !_genderOptions.contains(genderValue)) {
                          genderValue = null;
                        }

                        return DropdownButton<String>(
                          value: genderValue,
                          hint: const Text("Select gender"),
                          items: _genderOptions
                              .map((g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g == 'm' ? 'Male' : 'Female'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => genderValue = value);
                            if (value != null) widget.onAnswerSelected?.call(value);
                          },
                        );
                      })
                    else
                      // fallback empty container for other types
                      const SizedBox.shrink(),
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
