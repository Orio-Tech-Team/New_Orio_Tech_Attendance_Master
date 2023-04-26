import 'dart:io';
import 'package:dio/dio.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';

import '../Utils/Dialoug Box/custom_dialoug_box.dart';

class Network {
  static Response? response;
  static final Dio _dio = Dio();

  static Future<dynamic> postApi(var token, var endUrl, var data) async {
    try {
      response = await _dio.post(
        '$endUrl',
        options: Options(headers: {
          'Content-Type': "application/json",
        }),
        data: data,
      );
      return response!.data;
    } on DioError catch (e) {
      if (e.response == null) {
        customSnackBar("Network Error", "Ooops no internet found!");
      } else {
        return e.response!.data;
      }
    }
  }

  static Future<dynamic> getApi(var token, var endUrl) async {
    try {
      response = await _dio.get('$SECOND_URL$endUrl',
          options: Options(headers: {
            'Accept': "application/json",
            HttpHeaders.authorizationHeader: 'Bearer $token'
          }));
      return response!.data;
    } on DioError catch (e) {
      print('=======> Api error: ${e.error}');
      return e.response!.data;
    }
  }
}
