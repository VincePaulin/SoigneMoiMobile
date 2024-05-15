import 'package:flutter/foundation.dart';

class Endpoints {
  static const String stagingUrl = 'http://127.0.0.1:8000/api';
  static const String productionUrl = '';
  static const String baseUrl = kDebugMode ? stagingUrl : productionUrl;
  static const String login = '$baseUrl/auth/doctor/login';
}
