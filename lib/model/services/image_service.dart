import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../app_exceptions.dart';
import 'base_service.dart';

class ImageService extends BaseService {
  final Dio dio = Dio();

  @override
  Future getResponse(String url) async {
    dynamic jsonResponse;
    try {
      var response =
          await dio.get("$baseUrl/$url", options: Options(headers: {"Authorization": "3cP0YMhJcIoIOkPKwY1Aw80Ow1VFNNXJv2Z5qWnden4GR7uN4yIYlWOQ"}));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet.");
    }

    return jsonResponse;
  }

  returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        if (response.data is String) {
          return json.decode(response.data);
        } else {
          return response.data; // Return as-is, assuming it's already decoded
        }

      case 400:
        throw BadRequestException(message: response.data);

      case 401:
      case 403:
        throw UnAuthorizedException(message: response.data);

      case 500:
      default:
        throw FetchDataException(message: "Error occured while communication with server with status code ${response.statusCode}");
    }
  }
}
