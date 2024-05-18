import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soigne_moi_mobile/api/services/endpoints.dart';
import 'package:soigne_moi_mobile/model/prescription.dart';
import 'package:soigne_moi_mobile/model/review.dart';

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
      if (e.type == DioExceptionType.connectionError) {
        throw 'Erreur de réseau';
      }
      final errorMessage =
          e.response?.data['error'] ?? e.response?.data['message'];
      throw errorMessage;
    } catch (e) {
      throw 'Erreur de réseau';
    }
  }

  // Function to create a medical review
  Future<void> createMedicalReview(ReviewModel review) async {
    dio.options.baseUrl = Endpoints.baseUrl;

    final Map<String, dynamic> reviewJson = review.toJson();

    try {
      final response = await dio.post(
        '/doctor/create-review',
        data: reviewJson,
        options: await _generateOptions(),
      );

      // Check if the response status code is OK (201)
      if (response.statusCode == 201) {
        // Avis créé avec succès
        if (kDebugMode) {
          print('Avis médical créé avec succès');
        }
      } else {
        // Error when creating medical advice
        final messageError = response.data['message'];
        throw messageError;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw 'Erreur de réseau';
      }
      final messageError =
          e.response?.data['message'] ?? "Une erreur s'est produite";
      throw messageError;
    } catch (e) {
      throw 'Erreur de réseau';
    }
  }

  // Function to create a prescription
  Future<void> createPrescription(Prescription prescription) async {
    dio.options.baseUrl = Endpoints.baseUrl;

    final Map<String, dynamic> prescriptionJson = prescription.toJson();

    try {
      final response = await dio.post(
        '/doctors/prescription',
        data: prescriptionJson,
        options: await _generateOptions(),
      );

      // Check if the response status code is OK (201)
      if (response.statusCode == 201) {
        // Prescription créée avec succès
        if (kDebugMode) {
          print('Prescription créée avec succès');
        }
      } else {
        // Error when creating prescription
        final messageError = response.data['message'];
        throw Exception(messageError);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw 'Erreur de réseau';
      }
      final messageError =
          e.response?.data['message'] ?? "Une erreur s'est produite";
      throw messageError;
    } catch (e) {
      throw 'Erreur de réseau';
    }
  }

  // Function to get patient records
  Future<Map<String, dynamic>> getPatientRecords(String patientId) async {
    dio.options.baseUrl = Endpoints.baseUrl;

    try {
      final response = await dio.get(
        '/doctors/patient-records',
        data: {'patient_id': patientId},
        options: await _generateOptions(),
      );

      final data = response.data;

      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw 'Erreur de réseau';
      }
      final errorMessage =
          e.response?.data['error'] ?? e.response?.data['message'];
      throw errorMessage;
    } catch (e) {
      throw 'Erreur de réseau';
    }
  }

  Future<void> updatePrescriptionEndDate(
      int prescriptionId, DateTime endDate) async {
    dio.options.baseUrl = Endpoints.baseUrl;

    final data = {
      'prescription_id': prescriptionId,
      'end_date': endDate.toIso8601String(),
    };

    try {
      final response = await dio.post(
        '/doctor/update-prescription-end-date',
        data: data,
        options: await _generateOptions(),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Date de fin mise à jour avec succès');
        }
      } else {
        throw 'Erreur lors de la mise à jour de la date de fin';
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw 'Erreur de réseau';
      }
      final errorMessage =
          e.response?.data['message'] ?? "Une erreur s'est produite";
      throw errorMessage;
    } catch (e) {
      throw 'Erreur de réseau';
    }
  }
}
