// ignore_for_file: avoid_print

import 'dart:io';
import 'package:gp/core/api_service.dart';
import 'package:path/path.dart' as p;
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
part 'getvideo_state.dart';

class GetvideoCubit extends Cubit<GetvideoState> {
  GetvideoCubit() : super(GetvideoFail());
String word = '';
  VideoPlayerController? controller;
  final ImagePicker picker = ImagePicker();
  XFile? file;
  Future<void> getVideoFromGallery() async {
    print("function one");
    file = await picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      controller = VideoPlayerController.file(
        File(file?.path ?? ""),
      )..initialize();

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }

    controller?.dispose();
  }

  //Image Picker function to get image from camera
  Future<void> getVideoFromCameraOneSecond() async {
    print("function two");

    file = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 1, milliseconds: 50));
    if (file != null) {
      controller = VideoPlayerController.file(
        File(file?.path ?? ''),
      )..initialize();
      print("FADY :: ${p.extension(file?.path ?? '')}");
      print("FADY :: ${file?.name}");
      print("FADY :: $file");

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }
    controller?.dispose();
  }

  Future<void> getVideoFromCameraTwoSecond() async {
    print("function three");

    file = await picker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 2));
    if (file != null) {
      controller = VideoPlayerController.file(
        File(file?.path ?? ""),
      )..initialize();

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }
    controller?.dispose();
  }

  void justState() {
    emit(ChangeView());
  }

  ApiService api = ApiService();

  postData(path, name) {
    emit(PredictLoading());
    
    api.sendVidioToNgrok(path, name).then((value) {
      word = value;
      print('FFUUFFUFFUFUFUFUFUFUFUFUFFU');
      print('KERO FROM POST DATA :: $word');
      emit(PredictSuccess(word));
      return word;
    }).catchError((e) {
      emit(PredictError(e.toString()));
      return word;
    });
    
  }
}
