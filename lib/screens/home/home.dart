import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  List<Appointment> allAppointments = [];
  List<Appointment> todayAppointments = [];
  bool loading = true;
  Appointment? appointmentSelected;

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

      final appointmentsForToday = getAppointmentsForToday(appointmentsData);
      setState(() {
        doctor = Doctor.fromJson(doctorJson);
        allAppointments = appointmentsData;
        todayAppointments = appointmentsForToday;
        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch doctor agenda: $e');
      }
    }
  }

  List<Appointment> getAppointmentsForToday(List<Appointment> appointments) {
    final today = DateTime.now();
    return appointments.where((appointment) {
      // Check if today's date is between startDate and endDate inclusive
      return appointment.startDate
              .isBefore(today.add(const Duration(days: 1))) &&
          appointment.endDate.isAfter(today.subtract(const Duration(days: 1)));
    }).toList();
  }

  Future<void> selectAppointment(Appointment appointment) async {
    try {
      setState(() {
        loading = true;
        appointmentSelected = appointment;
        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch doctor agenda: $e');
      }
    }
  }

  Future<void> clearSelectAppointment() async {
    try {
      setState(() {
        loading = true;
        appointmentSelected = null;
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
