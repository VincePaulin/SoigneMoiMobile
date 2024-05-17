import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/api/services/api_service.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';
import 'package:soigne_moi_mobile/model/doctor.dart';
import 'package:soigne_moi_mobile/model/prescription.dart';
import 'package:soigne_moi_mobile/model/review.dart';
import 'package:soigne_moi_mobile/screens/home/home_page.dart';
import 'package:soigne_moi_mobile/widgets/error_dialog.dart';

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

  TextEditingController libelleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> drugs = [];
  String? selectedDrug;

  List<Drug> prescribedDrugs = [];

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

  Future<void> submitMedicalReview() async {
    try {
      String libelle = libelleController.text;
      String description = descriptionController.text;
      final patientId = appointmentSelected?.patient.id;

      final review = ReviewModel(
          title: libelle,
          description: description,
          patientId: patientId.toString());

      await Api().createMedicalReview(review);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Avis envoyé'),
            content: Text('Votre avis médical a été envoyé avec succès.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showErrorDialog(e.toString(), context);
    }

    libelleController.clear();
    descriptionController.clear();
  }

  Future<void> fetchDrugs() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.fda.gov/drug/label.json?count=openfda.brand_name.exact',
      );

      if (response.statusCode == 200) {
        final decodedData = response.data;

        // Vérifiez si la clé "results" existe dans les données décodées
        if (decodedData.containsKey('results')) {
          // Extraire la liste de médicaments de la clé "results"
          final drugsList = (decodedData['results'] as List)
              .map((item) => item['term'].toString())
              .toList();

          setState(() {
            drugs = drugsList;
          });
        } else {
          throw Exception('No data found');
        }
      } else {
        throw Exception('Failed to load drugs');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching drugs: $e');
      }
    }
  }

  void addDrug(Drug drug) {
    setState(() {
      prescribedDrugs.add(drug);
    });
  }

  void removeDrug(Drug drug) {
    setState(() {
      prescribedDrugs.remove(drug);
    });
  }

  void createPrescription() {
    // Logic for creating prescriptions with drugs
    if (kDebugMode) {
      print('Prescription créée avec ${prescribedDrugs.length} médicaments');
    }
    // Action to create
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
