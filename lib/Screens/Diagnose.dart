// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:path/path.dart' as p;
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:http_parser/http_parser.dart'; // for MediaType
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// // class VideoRecorderPage extends StatefulWidget {
// //   const VideoRecorderPage({super.key});

// //   @override
// //   State<VideoRecorderPage> createState() => _VideoRecorderPageState();
// // }

// // class _VideoRecorderPageState extends State<VideoRecorderPage> {
// //   CameraController? _controller;
// //   List<CameraDescription> _cameras = [];
// //   bool _isRecording = false;
// //   final bool _savingToGallery = true; // toggle if you want
// //   String? _lastSavedPath;
// //   YoutubePlayerController _youtubePlayerController = YoutubePlayerController(
// //       initialVideoId:
// //           YoutubePlayer.convertUrlToId('https://youtu.be/D5iM8UerZJY')!);
// //   Future<void> uploadVideoToFastAPI(String filePath) async {
// //     try {
// //       var uri = Uri.parse("http://:8000/upload-video");
// //       // For emulator, use 10.0.2.2 instead of 127.0.0.1
// //       // For real device, use your PC's local IP address
// //       print(
// //           "---------------------📹 Uploading video to FastAPI: $filePath--------------------------");
// //       var request = http.MultipartRequest('POST', uri);

// //       request.files.add(
// //         await http.MultipartFile.fromPath(
// //           'file', // must match your FastAPI parameter name
// //           filePath,
// //           contentType: MediaType('video', 'mp4'), // optional
// //         ),
// //       );
// //       print(
// //           "---------------📂 File added to request: $filePath ---------------------------");
// //       var response = await request.send();
// //       print("++++++++++++++++++ File sent: $filePath ++++++++++++++++");
// //       if (response.statusCode == 200) {
// //         var respStr = await response.stream.bytesToString();
// //         _showSnack("✅ Upload successful");
// //       } else {
// //         _showSnack("❌ Upload failed: ${response.statusCode}");
// //       }
// //     } catch (e) {
// //       _showSnack("⚠️ Error uploading video: $e");
// //     }
// //   }

// //   void _playVideo() {
// //     const videoUrl = 'https://youtu.be/D5iM8UerZJY';
// //     _youtubePlayerController = YoutubePlayerController(
// //       initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
// //       flags: const YoutubePlayerFlags(
// //         autoPlay: false,
// //         mute: false,
// //       ),
// //     );
// //   }

// //   Future<void> _init() async {
// //     WidgetsFlutterBinding.ensureInitialized();

// //     // Ask permissions up front
// //     final cam = await Permission.camera.request();
// //     final mic = await Permission.microphone.request();

// //     if (!cam.isGranted || !mic.isGranted) {
// //       if (mounted) {
// //         _showSnack('Camera/Microphone permission denied.');
// //       }
// //       return;
// //     }

// //     _cameras = await availableCameras();

// //     // Pick a back camera if available, else first camera
// //     final CameraDescription camera = _cameras.firstWhere(
// //         (c) => c.lensDirection == CameraLensDirection.front,
// //         orElse: () => _cameras.first);

// //     _controller = CameraController(
// //       camera,
// //       ResolutionPreset.high,
// //       enableAudio: true,
// //     );

// //     try {
// //       await _controller!.initialize();
// //       if (mounted) setState(() {});
// //     } on CameraException catch (e) {
// //       _showSnack('Camera init error: ${e.code}');
// //     }
// //   }

// //   // Future<void> _switchCamera() async {
// //   //   if (_controller == null || _cameras.length < 2 || _isRecording) return;

// //   //   final current = _controller!.description;
// //   //   final isBack = current.lensDirection == CameraLensDirection.back;
// //   //   final next = _cameras.firstWhere(
// //   //     (c) =>
// //   //         c.lensDirection ==
// //   //         (isBack ? CameraLensDirection.back : CameraLensDirection.front),
// //   //     orElse: () => _cameras.first,
// //   //   );

// //   //   await _controller!.dispose();
// //   //   _controller =
// //   //       CameraController(next, ResolutionPreset.high, enableAudio: true);
// //   //   try {
// //   //     await _controller!.initialize();
// //   //     if (mounted) setState(() {});
// //   //   } on CameraException catch (e) {
// //   //     _showSnack('Switch camera error: ${e.code}');
// //   //   }
// //   // }

// //   Future<void> _startRecording() async {
// //     if (_controller == null || _isRecording) return;
// //     try {
// //       await _controller!.prepareForVideoRecording();
// //       await _controller!.startVideoRecording();
// //       setState(() => _isRecording = true);
// //     } on CameraException catch (e) {
// //       _showSnack('Start recording error: ${e.code}');
// //     }
// //   }

// //   Future<void> _stopRecordingAndSave() async {
// //     if (_controller == null || !_isRecording) return;
// //     try {
// //       final XFile xfile = await _controller!.stopVideoRecording();
// //       setState(() => _isRecording = false);

// //       // Save to app documents directory
// //       final Directory docsDir = await getApplicationDocumentsDirectory();
// //       final String fileName =
// //           'VID_${DateTime.now().millisecondsSinceEpoch}.mp4';
// //       final String targetPath = p.join(docsDir.path, fileName);
// //       await xfile.saveTo(targetPath);

// //       _lastSavedPath = targetPath;
// //       await uploadVideoToFastAPI(targetPath);
// //       _showSnack('Video saved to:\n$targetPath');
// //       _showSnack('Saved to app storage:\n$targetPath');

// //       if (mounted) setState(() {});
// //     } on CameraException catch (e) {
// //       _showSnack('Stop/save error: ${e.code}');
// //     }
// //   }

// //   void _showSnack(String msg) {
// //     if (!mounted) return;
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// //   }

// //   @override
// //   void dispose() {
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = _controller;
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.landscapeLeft,
// //       DeviceOrientation.landscapeRight,
// //     ]);
// //     return Scaffold(
// //       body: controller == null
// //           ? const Center(child: CircularProgressIndicator())
// //           : (!controller.value.isInitialized)
// //               ? const Center(child: Text('Initializing camera...'))
// //               : Stack(
// //                   children: [
// //                     Center(child: CameraPreview(controller)),
// //                     Center(
// //                       child: YoutubePlayer(
// //                         controller: _youtubePlayerController,
// //                         showVideoProgressIndicator: true,
// //                       ),
// //                     ),
// //                     if (_isRecording)
// //                       Positioned(
// //                         top: 16,
// //                         left: 16,
// //                         child: Row(
// //                           children: const [
// //                             Icon(Icons.fiber_manual_record, color: Colors.red),
// //                             SizedBox(width: 8),
// //                             Text('REC', style: TextStyle(color: Colors.red)),
// //                           ],
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       floatingActionButton: Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           FloatingActionButton.extended(
// //             heroTag: 'record',
// //             onPressed: _isRecording ? _stopRecordingAndSave : _startRecording,
// //             label: Text(_isRecording ? 'Stop & Save' : 'Record'),
// //             icon: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:video_player/video_player.dart';

// class VideoRecorderPage extends StatefulWidget {
//   /// [videoAssetPath] should be the asset path included in pubspec.yaml
//   /// e.g. "assets/videos/demo.mp4"
//   final String videoAssetPath;

//   const VideoRecorderPage({
//     super.key,
//     required this.videoAssetPath,
//   });

//   @override
//   State<VideoRecorderPage> createState() => _VideoRecorderPageState();
// }

// class _VideoRecorderPageState extends State<VideoRecorderPage> {
//   CameraController? _cameraController;
//   List<CameraDescription> _cameras = [];
//   bool _isRecording = false;
//   String? _lastSavedPath;

//   /// Controller to play the asset video while recording
//   VideoPlayerController? _assetVideoController;

//   @override
//   void initState() {
//     super.initState();

//     // Force landscape as required
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);

//     // Initialize camera and video controller after first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showDisclaimerIfNeeded();
//       _initAll();
//     });
//   }

//   Future<void> _showDisclaimerIfNeeded() async {
//     // show disclaimer dialog on page load
//     await showDialog(
//       context: context,
//       barrierDismissible:
//           false, // user must explicitly tap the button to dismiss (you can change)
//       builder: (context) {
//         return Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 700),
//             child: Material(
//               borderRadius: BorderRadius.circular(12),
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'Disclaimer',
//                       style:
//                           TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Recorded videos are used only for instant analysis within the app and will not be stored or shared anywhere. Your child\'s privacy and data safety are fully protected.',
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 18),
//                     ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('OK'),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _initAll() async {
//     await _requestPermissions();
//     await _initCameras();
//     await _initAssetVideo();
//   }

//   Future<void> _requestPermissions() async {
//     final cam = await Permission.camera.request();
//     final mic = await Permission.microphone.request();

//     if (!cam.isGranted || !mic.isGranted) {
//       if (mounted) {
//         _showSnack('Camera/Microphone permission denied.');
//       }
//     }
//   }

//   Future<void> _initCameras() async {
//     try {
//       _cameras = await availableCameras();

//       // Try front camera first (you had front in old code)
//       final CameraDescription camera = _cameras.firstWhere(
//         (c) => c.lensDirection == CameraLensDirection.front,
//         orElse: () => _cameras.first,
//       );

//       _cameraController =
//           CameraController(camera, ResolutionPreset.high, enableAudio: true);

//       await _cameraController!.initialize();
//       if (mounted) setState(() {});
//     } on CameraException catch (e) {
//       _showSnack('Camera init error: ${e.code} - ${e.description}');
//     } catch (e) {
//       _showSnack('Camera init unexpected error: $e');
//     }
//   }

//   Future<void> _initAssetVideo() async {
//     try {
//       _assetVideoController =
//           VideoPlayerController.asset(widget.videoAssetPath);
//       await _assetVideoController!.initialize();
//       _assetVideoController!.setLooping(false);
//       // Do not auto play; only play when recording starts.
//       if (mounted) setState(() {});
//     } catch (e) {
//       _showSnack('Asset video init error: $e');
//     }
//   }

//   Future<void> _startRecording() async {
//     if (_cameraController == null || _isRecording) return;

//     try {
//       await _cameraController!.prepareForVideoRecording();
//       await _cameraController!.startVideoRecording();
//       // start playback of asset video so user can follow along
//       if (_assetVideoController != null &&
//           !_assetVideoController!.value.isPlaying) {
//         await _assetVideoController!.play();
//       }
//       setState(() => _isRecording = true);
//     } on CameraException catch (e) {
//       _showSnack('Start recording error: ${e.code}');
//     } catch (e) {
//       _showSnack('Start recording unexpected error: $e');
//     }
//   }

//   Future<void> _stopRecordingAndSave() async {
//     if (_cameraController == null || !_isRecording) return;

//     try {
//       final XFile xfile = await _cameraController!.stopVideoRecording();

//       // stop asset playback
//       if (_assetVideoController != null &&
//           _assetVideoController!.value.isPlaying) {
//         await _assetVideoController!.pause();
//         await _assetVideoController!.seekTo(Duration.zero);
//       }

//       setState(() => _isRecording = false);

//       // Save to app documents directory
//       final Directory docsDir = await getApplicationDocumentsDirectory();
//       final String fileName =
//           'VID_${DateTime.now().millisecondsSinceEpoch}.mp4';
//       final String targetPath = p.join(docsDir.path, fileName);

//       await xfile.saveTo(targetPath);
//       _lastSavedPath = targetPath;

//       // Upload (change the URL below to your server's URL)
//       await uploadVideoToFastAPI(targetPath);

//       _showSnack('Saved to app storage:\n$targetPath');
//       if (mounted) setState(() {});
//     } on CameraException catch (e) {
//       _showSnack('Stop/save error: ${e.code}');
//     } catch (e) {
//       _showSnack('Stop/save unexpected error: $e');
//     }
//   }

//   Future<void> uploadVideoToFastAPI(String filePath) async {
//     try {
//       // TODO: Replace with your server URL. Example for emulator: "http://10.0.2.2:8000/upload-video"
//       // final uri = Uri.parse('http://10.0.2.2:8000/upload-video');

//       // var request = http.MultipartRequest('POST', uri);
//       // request.files.add(await http.MultipartFile.fromPath(
//       //   'file',
//       //   filePath,
//       //   contentType: MediaType('video', 'mp4'),
//       // ));
//       // final streamedResponse = await request.send();
//       // if (streamedResponse.statusCode == 200) {
//       //   final respStr = await streamedResponse.stream.bytesToString();
//       //   _showSnack('✅ Upload successful');
//       // } else {
//       //   _showSnack('❌ Upload failed: ${streamedResponse.statusCode}');
//       // }
//       print(
//           "-----------------------------Sucesss---------------------------------");
//     } catch (e) {
//       _showSnack('⚠️ Error uploading video: $e');
//     }
//   }

//   void _showSnack(String msg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }

//   @override
//   void dispose() {
//     _assetVideoController?.dispose();
//     _cameraController?.dispose();
//     // reset orientation to allow portrait after leaving page (optional)
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = _cameraController;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: controller == null
//           ? const Center(child: CircularProgressIndicator())
//           : (!controller.value.isInitialized)
//               ? const Center(
//                   child: Text('Initializing camera...',
//                       style: TextStyle(color: Colors.white)))
//               : Stack(
//                   children: [
//                     // Camera preview fills background
//                     Positioned.fill(
//                       child: CameraPreview(controller),
//                     ),

//                     // If asset video controller is ready and (optionally) recording,
//                     // show the asset video centered with rounded corners to mimic your screenshots.
//                     if (_assetVideoController != null &&
//                         _assetVideoController!.value.isInitialized)
//                       Center(
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.75,
//                           height: MediaQuery.of(context).size.height * 0.75,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: AspectRatio(
//                               aspectRatio:
//                                   _assetVideoController!.value.aspectRatio,
//                               child: VideoPlayer(_assetVideoController!),
//                             ),
//                           ),
//                         ),
//                       ),

//                     // Top-left recording indicator
//                     if (_isRecording)
//                       const Positioned(
//                         top: 16,
//                         left: 16,
//                         child: Row(
//                           children: [
//                             Icon(Icons.fiber_manual_record, color: Colors.red),
//                             SizedBox(width: 8),
//                             Text('REC', style: TextStyle(color: Colors.red)),
//                           ],
//                         ),
//                       ),

//                     // last saved path indicator (bottom-left)
//                     if (_lastSavedPath != null)
//                       Positioned(
//                         left: 16,
//                         bottom: 110,
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           color: Colors.black.withOpacity(0.6),
//                           child: Text(
//                             'Saved: ${_lastSavedPath!.split('/').last}',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FloatingActionButton.extended(
//             heroTag: 'record',
//             onPressed: _isRecording ? _stopRecordingAndSave : _startRecording,
//             label: Text(_isRecording ? 'Stop & Save' : 'Record'),
//             icon: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
//           ),
//           const SizedBox(width: 12),
//           FloatingActionButton.extended(
//             heroTag: 'play_asset',
//             onPressed: () async {
//               // Manually play/pause the asset video (useful for preview)
//               if (_assetVideoController == null) return;
//               if (_assetVideoController!.value.isPlaying) {
//                 await _assetVideoController!.pause();
//               } else {
//                 await _assetVideoController!.play();
//               }
//               if (mounted) setState(() {});
//             },
//             label: Text(_assetVideoController?.value.isPlaying == true
//                 ? 'Pause Video'
//                 : 'Play Video'),
//             icon: Icon(_assetVideoController?.value.isPlaying == true
//                 ? Icons.pause
//                 : Icons.play_arrow),
//           ),
//         ],
//       ),
//     );
//   }
// }
