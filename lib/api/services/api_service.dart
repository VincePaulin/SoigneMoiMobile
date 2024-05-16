import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soigne_moi_mobile/api/services/endpoints.dart';

class Api {
  final storage = FlutterSecureStorage();
  final dio = Dio();

  // Function to generate options with authentication token and JSON acceptance
  Future<Options> _generateOptions() async {
    final token = await _getToken();
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  // How to retrieve the token
  Future<String> _getToken() async {
    return await storage.read(key: 'access_token') ?? '';
  }

  Future<Map<String, dynamic>> fetchDoctorAgenda() async {
    dio.options.baseUrl = Endpoints.baseUrl;

    try {
      final response = await dio.get(
        '/doctor/get-data',
        options: await _generateOptions(),
      );

      final data = response.data;

      return data;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['error'] ?? e.response?.data['message'];
      throw errorMessage;
    }
  }
}
