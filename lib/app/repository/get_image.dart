import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nasa/app/data/image_response.dart';

import '../utils/constants.dart';

Future<NasaImageResponse?> getImageApi(Map<String, dynamic> values) async {
  String url = Constants.baseUrl;
  var dioClient = Dio();
  dioClient.options.headers = {
    'Accept': "application/json",
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'X-Requested-With': "XMLHttpRequest",
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    'Access-Control-Allow-Methods': "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  };

  try {
    //final response = await dioClient.get(url,queryParameters: {'api_key':"18QBwoiRpbFgeYBSl3PxFHi2aoJjrt7lIindJfng"}, data: values);
    final response = await dioClient.get(url,queryParameters: values);
    if (kDebugMode) {
      print('Response data: ${response.data}');
    }

    if (response.statusCode == 200 && response.data != null) {
      return NasaImageResponse.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print('Unexpected status code or missing status_code in response: ${response.statusCode}, ${response.data}');
      }
      // If there's an unexpected status code or missing status_code, throw an exception
      throw Exception('Unexpected response from server');
    }
  } on DioException catch (e) {
    if (kDebugMode) {
      print('DioException: ${e.type}, ${e.response}');
    }

    if (e.type == DioExceptionType.connectionError) {
      throw Exception("Your internet connection is unstable. Please re-check or try again later.");
    } else {
      throw Exception(e.response?.data["status"] ?? 'Unknown error');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Unexpected error: $e');
    }
    throw e.toString();
  }
}
