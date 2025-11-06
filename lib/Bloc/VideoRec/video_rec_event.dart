import 'package:equatable/equatable.dart';

abstract class VideoRecorderEvent extends Equatable {
  const VideoRecorderEvent();

  @override
  List<Object?> get props => [];
}

class InitializeVideoRecorder extends VideoRecorderEvent {
  final String assetPath;
  const InitializeVideoRecorder(this.assetPath);

  @override
  List<Object?> get props => [assetPath];
}

class StartRecording extends VideoRecorderEvent {}

class StopRecording extends VideoRecorderEvent {}

class ToggleAssetPlayback extends VideoRecorderEvent {}

class UploadVideo extends VideoRecorderEvent {
  final String filePath;
  const UploadVideo(this.filePath);

  @override
  List<Object?> get props => [filePath];
}
