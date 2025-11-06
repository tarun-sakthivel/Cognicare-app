import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderState extends Equatable {
  final CameraController? cameraController;
  final VideoPlayerController? assetVideoController;
  final bool isRecording;
  final bool isInitialized;
  final String? lastSavedPath;
  final String? message;
  final bool? videoSent;

  const VideoRecorderState(
      {this.cameraController,
      this.assetVideoController,
      this.isRecording = false,
      this.isInitialized = false,
      this.lastSavedPath,
      this.message,
      this.videoSent = false});

  VideoRecorderState copyWith(
      {CameraController? cameraController,
      VideoPlayerController? assetVideoController,
      bool? isRecording,
      bool? isInitialized,
      String? lastSavedPath,
      String? message,
      bool? videoSent}) {
    return VideoRecorderState(
        cameraController: cameraController ?? this.cameraController,
        assetVideoController: assetVideoController ?? this.assetVideoController,
        isRecording: isRecording ?? this.isRecording,
        isInitialized: isInitialized ?? this.isInitialized,
        lastSavedPath: lastSavedPath ?? this.lastSavedPath,
        message: message,
        videoSent: videoSent);
  }

  @override
  List<Object?> get props => [
        cameraController,
        assetVideoController,
        isRecording,
        isInitialized,
        lastSavedPath,
        message,
        videoSent
      ];
}
