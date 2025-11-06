import 'package:cognicare/Bloc/VideoRec/video_rec_event.dart'
    show
        InitializeVideoRecorder,
        StopRecording,
        StartRecording,
        ToggleAssetPlayback;
import 'package:cognicare/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

import '../Bloc/VideoRec/video_rec_bloc.dart';
import '../Bloc/VideoRec/video_rec_state.dart';

class VideoRecorderPage extends StatelessWidget {
  final String assetPath;
  const VideoRecorderPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          VideoRecorderBloc()..add(InitializeVideoRecorder(assetPath)),
      child: BlocConsumer<VideoRecorderBloc, VideoRecorderState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
          if (state.videoSent == true && context.mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
            backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
            body: Stack(
              children: [
                if (state.cameraController != null)
                  Positioned.fill(
                      child: CameraPreview(state.cameraController!)),
                if (state.assetVideoController != null &&
                    state.assetVideoController!.value.isInitialized)
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio:
                              state.assetVideoController!.value.aspectRatio,
                          child: VideoPlayer(state.assetVideoController!),
                        ),
                      ),
                    ),
                  ),
                if (!state.isRecording)
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DISCLAIMER\nRecorded videos are used only for instant analysis within the app and will not be stored or shared anywhere. Your child\'s privacy and data safety are fully protected. \n First click the play video button and then the record button to start recording.\n - Cognicare Team',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (state.isRecording)
                  const Positioned(
                    top: 16,
                    left: 16,
                    child: Row(
                      children: [
                        Icon(Icons.fiber_manual_record, color: Colors.red),
                        SizedBox(width: 8),
                        Text('REC', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color.fromARGB(255, 255, 138, 138),
                  heroTag: 'record',
                  onPressed: state.isRecording
                      ? () => {bloc.add(StopRecording())}
                      : () => bloc.add(StartRecording()),
                  label: Text(state.isRecording ? 'Stop & Save' : 'Record'),
                  icon: Icon(state.isRecording
                      ? Icons.stop
                      : Icons.fiber_manual_record),
                ),
                const SizedBox(width: 12),
                FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  heroTag: 'play_asset',
                  onPressed: () => bloc.add(ToggleAssetPlayback()),
                  label: Text(
                      state.assetVideoController?.value.isPlaying == true
                          ? 'Pause Video'
                          : 'Play Video'),
                  icon: Icon(state.assetVideoController?.value.isPlaying == true
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
