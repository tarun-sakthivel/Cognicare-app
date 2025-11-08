import 'package:cognicare/Screens/VideoRec.dart' show VideoRecorderPage;
import 'package:cognicare/constants/text.dart';
import 'package:flutter/material.dart';

class VideoSelection extends StatefulWidget {
  const VideoSelection({super.key});

  @override
  State<VideoSelection> createState() => _VideoSelectionState();
}

class _VideoSelectionState extends State<VideoSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select video to play",
          style: knormalTextStyle.copyWith(
              fontSize: 24, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select a video which your baby may \n                    like to proceed",
              style: knormalTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(132, 132, 132, 1),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Video 3
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoRecorderPage(
                          assetPath: "assets/VideoFile/Baby Shark.mp4"),
                    ));
              },
              child: Image.asset("assets/Images/Shark.png"),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Video 2
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoRecorderPage(
                          assetPath: "assets/VideoFile/Wheels on the Bus.mp4"),
                    ));
              },
              child: Image.asset("assets/Images/Coco.png"),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Video 3
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoRecorderPage(
                          assetPath: "assets/VideoFile/Poochandi.mp4"),
                    ));
              },
              child: Image.asset("assets/Images/Fox.png"),
            ),
          ],
        ),
      ),
    );
  }
}
