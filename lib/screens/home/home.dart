import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/api/services/api_service.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';
import 'package:soigne_moi_mobile/model/doctor.dart';
import 'package:soigne_moi_mobile/screens/home/home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<Home> {
  Doctor? doctor;
  List<Appointment> appointments = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final Map<String, dynamic> data = await Api().fetchDoctorAgenda();

      final doctorJson = data['doctor'];
      final List<dynamic> appointmentsJson = data['appointments'];

      final List<Appointment> appointmentsData =
          appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
      setState(() {
        doctor = Doctor.fromJson(doctorJson);
        appointments = appointmentsData;
        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch doctor agenda: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading != true) {
      return HomePage(
        controller: this,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
