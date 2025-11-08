// import 'package:cognicare/Bloc/VideoRec/video_rec_event.dart'
//     show
//         InitializeVideoRecorder,
//         StopRecording,
//         StartRecording,
//         ToggleAssetPlayback;
// import 'package:cognicare/Screens/Home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/services.dart';

// import '../Bloc/VideoRec/video_rec_bloc.dart';
// import '../Bloc/VideoRec/video_rec_state.dart';

// class VideoRecorderPage extends StatefulWidget {
//   final String assetPath;
//   const VideoRecorderPage({super.key, required this.assetPath});

//   @override
//   State<VideoRecorderPage> createState() => _VideoRecorderPageState();
// }

// class _VideoRecorderPageState extends State<VideoRecorderPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Force landscape orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }

//   @override
//   void dispose() {
//     // Restore portrait orientation when leaving
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     // context.read<VideoRecorderBloc>().close();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           VideoRecorderBloc()..add(InitializeVideoRecorder(widget.assetPath)),
//       child: BlocConsumer<VideoRecorderBloc, VideoRecorderState>(
//         listener: (context, state) {
//           if (state.message != null) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message!)));
//           }
//           if (state.videoSent == true && context.mounted) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomePage()),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (!state.isInitialized) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final bloc = context.read<VideoRecorderBloc>();

//           return Scaffold(
//             backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//             body: Row(
//               children: [
//                 // 🎥 Video preview section
//                 Expanded(
//                   //flex: 4,
//                   child: Stack(
//                     children: [
//                       // if (state.cameraController != null)
//                       //   Positioned.fill(
//                       //     child: CameraPreview(state.cameraController!),
//                       //   ),
//                       if (state.assetVideoController != null &&
//                           state.assetVideoController!.value.isInitialized)
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: AspectRatio(
//                               aspectRatio:
//                                   state.assetVideoController!.value.aspectRatio,
//                               child: VideoPlayer(state.assetVideoController!),
//                             ),
//                           ),
//                         ),
//                       if (!state.isRecording)
//                         Center(
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             margin: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: const Text(
//                               'DISCLAIMER\n\nRecorded videos are used only for instant analysis within the app and will not be stored or shared anywhere.\n\nYour child\'s privacy and data safety are fully protected.\n\n👉 First click the play video button and then the record button to start recording.\n\n- Cognicare Team',
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 14),
//                             ),
//                           ),
//                         ),
//                       if (state.isRecording)
//                         const Positioned(
//                           top: 16,
//                           left: 16,
//                           child: Row(
//                             children: [
//                               Icon(Icons.fiber_manual_record,
//                                   color: Colors.red),
//                               SizedBox(width: 8),
//                               Text('REC', style: TextStyle(color: Colors.red)),
//                             ],
//                           ),
//                         ),
//                       Positioned(
//                           right: 20,
//                           bottom: 60,
//                           child: Builder(
//                             builder: (context) {
//                               return Colum
//                               n(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   FloatingActionButton.extended(
//                                     backgroundColor: Colors.black,
//                                     foregroundColor: const Color.fromARGB(
//                                         255, 255, 138, 138),
//                                     heroTag: 'record',
//                                     onPressed: state.isRecording
//                                         ? () => bloc.add(StopRecording())
//                                         : () => bloc.add(StartRecording()),
//                                     label: Text(
//                                       state.isRecording
//                                           ? 'Stop & Save'
//                                           : 'Record',
//                                     ),
//                                     icon: Icon(
//                                       state.isRecording
//                                           ? Icons.stop
//                                           : Icons.fiber_manual_record,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 12),
//                                   FloatingActionButton.extended(
//                                     backgroundColor: Colors.black,
//                                     foregroundColor: Colors.white,
//                                     heroTag: 'play_asset',
//                                     onPressed: () =>
//                                         bloc.add(ToggleAssetPlayback()),
//                                     label: Text(
//                                       state.assetVideoController?.value
//                                                   .isPlaying ==
//                                               true
//                                           ? 'Pause Video'
//                                           : 'Play Video',
//                                     ),
//                                     icon: Icon(
//                                       state.assetVideoController?.value
//                                                   .isPlaying ==
//                                               true
//                                           ? Icons.pause
//                                           : Icons.play_arrow,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cognicare/Bloc/VideoRec/video_rec_event.dart'
    show
        InitializeVideoRecorder,
        StopRecording,
        StartRecording,
        ToggleAssetPlayback;
import 'package:cognicare/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../Bloc/VideoRec/video_rec_bloc.dart';
import '../Bloc/VideoRec/video_rec_state.dart';

class VideoRecorderPage extends StatefulWidget {
  final String assetPath;
  const VideoRecorderPage({super.key, required this.assetPath});

  @override
  State<VideoRecorderPage> createState() => _VideoRecorderPageState();
}

class _VideoRecorderPageState extends State<VideoRecorderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Restore default behavior — no forced orientation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          VideoRecorderBloc()..add(InitializeVideoRecorder(widget.assetPath)),
      child: BlocConsumer<VideoRecorderBloc, VideoRecorderState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
          if (state.videoSent == true && context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          if (!state.isInitialized) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final bloc = context.read<VideoRecorderBloc>();

          return Scaffold(
            backgroundColor: Colors.black,
            body: OrientationBuilder(
              builder: (context, orientation) {
                return Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          if (state.assetVideoController != null &&
                              state.assetVideoController!.value.isInitialized)
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio: state
                                      .assetVideoController!.value.aspectRatio,
                                  child:
                                      VideoPlayer(state.assetVideoController!),
                                ),
                              ),
                            ),
                          if (!state.isRecording)
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'DISCLAIMER\n\nRecorded videos are used only for instant analysis within the app and will not be stored or shared anywhere.\n\nYour child\'s privacy and data safety are fully protected.\n\n👉 First click the play video button and then the record button to start recording.\n\n- Cognicare Team',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          if (state.isRecording)
                            const Positioned(
                              top: 16,
                              left: 16,
                              child: Row(
                                children: [
                                  Icon(Icons.fiber_manual_record,
                                      color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('REC',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          Positioned(
                            right: 20,
                            bottom: 60,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.black,
                                  foregroundColor:
                                      const Color.fromARGB(255, 255, 138, 138),
                                  heroTag: 'record',
                                  onPressed: state.isRecording
                                      ? () => bloc.add(StopRecording())
                                      : () => bloc.add(StartRecording()),
                                  label: Text(
                                    state.isRecording
                                        ? 'Stop & Save'
                                        : 'Record',
                                  ),
                                  icon: Icon(
                                    state.isRecording
                                        ? Icons.stop
                                        : Icons.fiber_manual_record,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  heroTag: 'play_asset',
                                  onPressed: () =>
                                      bloc.add(ToggleAssetPlayback()),
                                  label: Text(
                                    state.assetVideoController?.value
                                                .isPlaying ==
                                            true
                                        ? 'Pause Video'
                                        : 'Play Video',
                                  ),
                                  icon: Icon(
                                    state.assetVideoController?.value
                                                .isPlaying ==
                                            true
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
