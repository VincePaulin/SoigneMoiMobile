import 'package:soigne_moi_mobile/model/user.dart';

import 'doctor.dart';

// Template for showing an appointment
class Appointment {
  final String? id;
  final DateTime startDate;
  final DateTime endDate;
  final User patient;
  final String doctorMatricule;
  final String stayId;
  final String motif;

  Appointment({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.patient,
    required this.doctorMatricule,
    required this.stayId,
    required this.motif,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'].toString(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      patient: User.fromJson(json['patient']),
      doctorMatricule: json['doctor_matricule'].toString(),
      stayId: json['stay_id'].toString(),
      motif: json['motif'] ?? "",
    );
  }
}

// Model to represent a doctor's schedule
class Agenda {
  final String id;
  final Doctor doctor;
  late final List<Appointment> appointments;
  late int? demandsCount;

  Agenda({
    required this.id,
    required this.doctor,
    required this.appointments,
    this.demandsCount,
  });

  // Function to convert JSON to Agenda object
  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json['id'].toString(),
      doctor: Doctor.fromJson(json['doctor']),
      appointments: [],
      //appointments: List<Appointment>.from(json['appointments'].map((x) => Appointment.fromJson(x))),
    );
  }
}
