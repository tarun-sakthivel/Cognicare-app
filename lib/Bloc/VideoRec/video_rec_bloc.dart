import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cognicare/Bloc/VideoRec/video_rec_event.dart'
    show
        ToggleAssetPlayback,
        StartRecording,
        StopRecording,
        UploadVideo,
        VideoRecorderEvent,
        InitializeVideoRecorder;
import 'package:cognicare/Bloc/VideoRec/video_rec_state.dart';
import 'package:cognicare/utils/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderBloc extends Bloc<VideoRecorderEvent, VideoRecorderState> {
  VideoRecorderBloc() : super(const VideoRecorderState()) {
    on<InitializeVideoRecorder>(_onInitialize);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<ToggleAssetPlayback>(_onToggleAssetPlayback);
    on<UploadVideo>(_onUploadVideo);
  }
  @override
  Future<void> close() async {
    try {
      await state.cameraController?.dispose();
      await state.assetVideoController?.dispose();
    } catch (e) {
      print("⚠️ Error disposing controllers: $e");
    }
    return super.close();
  }

  Future<void> _onInitialize(
      InitializeVideoRecorder event, Emitter<VideoRecorderState> emit) async {
    try {
      final cam = await Permission.camera.request();
      final mic = await Permission.microphone.request();
      if (!cam.isGranted || !mic.isGranted) {
        emit(state.copyWith(message: 'Camera/Microphone permission denied.'));
        return;
      }
// Dispose old controllers safely before reinitializing
      await state.cameraController?.dispose();
      await state.assetVideoController?.dispose();

      final cameras = await availableCameras();
      final CameraDescription camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller =
          CameraController(camera, ResolutionPreset.medium, enableAudio: true);
      await controller.initialize();

      final assetController = VideoPlayerController.asset(event.assetPath);
      await assetController.initialize();
      assetController.setLooping(false);

      emit(state.copyWith(
        cameraController: controller,
        assetVideoController: assetController,
        isInitialized: true,
      ));
    } catch (e) {
      emit(state.copyWith(message: 'Initialization failed: $e'));
    }
  }

  Future<void> _onStartRecording(
      StartRecording event, Emitter<VideoRecorderState> emit) async {
    try {
      final controller = state.cameraController;
      if (controller == null) return;

      await controller.prepareForVideoRecording();
      await controller.startVideoRecording();
      await state.assetVideoController?.play();

      emit(state.copyWith(isRecording: true));
      await Future.delayed(const Duration(seconds: 60));
      add(StopRecording());
    } catch (e) {
      emit(state.copyWith(message: 'Start recording error: $e'));
    }
  }

  Future<void> _onStopRecording(
      StopRecording event, Emitter<VideoRecorderState> emit) async {
    try {
      final controller = state.cameraController;
      if (controller == null || !state.isRecording) return;

      final XFile file = await controller.stopVideoRecording();
      await state.assetVideoController?.pause();
      await state.assetVideoController?.seekTo(Duration.zero);

      final docsDir = await getApplicationDocumentsDirectory();
      final String fileName =
          'VID_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final String targetPath = p.join(docsDir.path, fileName);
      await file.saveTo(targetPath);

      emit(state.copyWith(
          isRecording: false,
          lastSavedPath: targetPath,
          message: 'Video saved!'));

      add(UploadVideo(targetPath));
    } catch (e) {
      emit(state.copyWith(message: 'Stop recording error: $e'));
    }
  }

  // Future<void> _onUploadVideo(
  //     UploadVideo event, Emitter<VideoRecorderState> emit) async {
  //   try {
  //     // final uri = Uri.parse('http://10.0.2.2:8000/upload-video');
  //     // var request = http.MultipartRequest('POST', uri);
  //     // request.files.add(await http.MultipartFile.fromPath(
  //     //   'file',
  //     //   event.filePath,
  //     //   contentType: MediaType('video', 'mp4'),
  //     // ));
  //     // final response = await request.send();

  //     // if (response.statusCode == 200) {
  //     //   emit(state.copyWith(message: '✅ Upload successful'));
  //     // } else {
  //     //   emit(state.copyWith(message: '❌ Upload failed: ${response.statusCode}'));
  //     // }
  //     print("---------------------Sucess---------------------");
  //   } catch (e) {
  //     emit(state.copyWith(message: '⚠️ Upload error: $e'));
  //   }
  // }

  // Future<void> _onUploadVideo(
  //     UploadVideo event, Emitter<VideoRecorderState> emit) async {
  //   try {
  //     final formData = SharedAnswers.answers; // ✅ get stored answers
  //     if (formData == null) {
  //       emit(state.copyWith(message: '⚠️ No form data found.'));
  //       return;
  //     }
  //         final baseUrl = dotenv.env['localhost1'] ?? 'http://10.0.2.2:8000';

  //   // ✅ 2. Get your auth token (from SharedPreferences or .env)
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('authToken') ?? '';

  //     if (token.isEmpty) {
  //       emit(state.copyWith(message: '⚠️ No auth token found.'));
  //       return;
  //     }
  //     final local = dotenv.env['localhost1'] ?? '';
  //     final uri = Uri.parse('$local/predict/combined');
  //     var request = http.MultipartRequest('POST', uri);
  //    request.files.add(await http.MultipartFile.fromPath(
  //     'file',
  //     event.filePath,
  //     contentType: MediaType('video', 'mp4'),
  //   ));
  //     // 🧩 Add all form fields (convert everything to string)
  //     formData.forEach((key, value) {
  //       request.fields[key] = value.toString();
  //     });

  //     // 🧩 Add the video file
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'file',
  //       event.filePath,
  //       contentType: MediaType('video', 'mp4'),
  //     ));

  //     // 🧩 Send the request
  //     final response = await request.send();
  //     final resp = await http.Response.fromStream(response);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       emit(state.copyWith(message: '✅ Video + Form uploaded successfully!'));
  //       print('✅ Upload Response: ${resp.body}');
  //     } else {
  //       emit(state.copyWith(
  //           message: '❌ Upload failed: ${response.statusCode}\n${resp.body}'));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(message: '⚠️ Upload error: $e'));
  //   }
  // }

  Future<void> _onUploadVideo(
      UploadVideo event, Emitter<VideoRecorderState> emit) async {
    try {
      emit(state.copyWith(
          message: '⏳ Uploading video and form...', videoSent: true));
      //  emit(state.copyWith(videoSent: true));
      // ✅ 1. Base URL (from .env or fallback)
      final baseUrl = dotenv.env['localhost1'] ?? 'http://10.0.2.2:8000';
      final uri = Uri.parse('$baseUrl/predict/combined');

      // ✅ 2. Token retrieval

      String? token = await LocalStorage.getString('authToken') ?? '';
      print("-TOKEN-------------------$token-----------------------");
      if (token.isEmpty) {
        emit(state.copyWith(message: '⚠️ Missing auth token.'));
        return;
      } else {
        print("----------------- stage 1---------------------");
      }
      print("--------------------$token-----------------------");

      // ✅ 3. Get saved answers from SharedPreferences (saved in QuestionsBloc)
      final formAnswersJson = await LocalStorage.getString('form_answers');
      print("----------------- stage 2--------------------");
      final formAnswers =
          jsonDecode(formAnswersJson ?? '{}') as Map<String, dynamic>;
      print("----------------- stage 3---------------------");
      // ✅ 4. Prepare multipart request
      var request = http.MultipartRequest('POST', uri);
      print("----------------- stage 4---------------------");
      // ✅ 5. Add video file
      print("📂 Uploading from: ${event.filePath}");
      final file = File(event.filePath);
      print("File exists: ${await file.exists()}");
      print("File size: ${await file.length()} bytes");

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        event.filePath,
        contentType: MediaType('video', 'mp4'),
      ));
      print("----------------- stage 5---------------------");
      // ✅ 6. Add all question fields exactly as backend expects
      // Backend expects A1–A10, Age_Mons, Sex, Ethnicity, Jaundice, Family_mem_with_ASD
      final requiredFields = [
        'A1',
        'A2',
        'A3',
        'A4',
        'A5',
        'A6',
        'A7',
        'A8',
        'A9',
        'A10',
        'Age_Mons',
        'Sex',
        'Ethnicity',
        'Jaundice',
        'Family_mem_with_ASD'
      ];

      for (var key in requiredFields) {
        if (formAnswers.containsKey(key)) {
          request.fields[key] = formAnswers[key].toString();
        } else {
          // Send default if missing
          request.fields[key] =
              (key.startsWith('A') || key == 'Age_Mons') ? '0' : 'unknown';
        }
      }
      print("----------------- stage 6 entering headers---------------------");
      // ✅ 7. Headers
      request.headers.addAll({
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("----------------- stage 7---------------------");
      // ✅ 8. Send request
      print("Sending to: ${request.url}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(message: '✅ Processing started.'));
      } else {
        emit(state.copyWith(message: '❌ Upload failed: $responseBody'));
      }

      print("----------------- stage 7.1---------------------");
      // final responseBody = await response.stream.bytesToString();

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   print("----------------- stage 8 emitted---------------------");
      //   emit(state.copyWith(
      //       message: '✅ Upload successful! Response: $responseBody'));
      //   print("----------------- stage 9 emit success---------------------");
      // } else {
      //   emit(state.copyWith(
      //     message:
      //         '❌ Upload failed [${response.statusCode}]: ${response.reasonPhrase}\n$responseBody',
      //   ));
      // }
      //emit(state.copyWith(message: "Upload Successful"));
    } catch (e) {
      emit(state.copyWith(message: '⚠️ Upload error: $e'));
      print("-Erorr:---------------- $e -----------------");
    }
  }

  Future<void> _onToggleAssetPlayback(
      ToggleAssetPlayback event, Emitter<VideoRecorderState> emit) async {
    final asset = state.assetVideoController;
    if (asset == null) return;
    if (asset.value.isPlaying) {
      await asset.pause();
    } else {
      await asset.play();
    }
    emit(state.copyWith());
  }
}
