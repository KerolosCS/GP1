// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();

  Future<String> sendVidioToNgrok(path, name) async {
    print('path $path');
    print('NAME $name');
    // name = 'v.mp4';
    try {
      print('TRYYYYYYY ');
      final formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            path,
            filename: '$name',
          ),
        },
      );
      final response = await dio.post(
        'https://079a-197-133-59-50.ngrok-free.app/Predict',
        data: formData,
      );
      print('response status code from SENDVID ::: ${response.statusCode}');

      return response.data.toString();
    } catch (e) {
      print("FADY_EXCEPTION :: ${e.toString()}");
      return 'GP ERROR';
    }
  }
}
