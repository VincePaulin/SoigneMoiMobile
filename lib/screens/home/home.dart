import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/api/services/api_service.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';
import 'package:soigne_moi_mobile/model/doctor.dart';
import 'package:soigne_moi_mobile/model/medical_folder.dart';
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
      print('Error fetching drugs: $e');
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

  void createPrescription(
      DateTime startDate, DateTime endDate, int patientId) async {
    final prescription = Prescription(
      patientId: patientId,
      drugs: prescribedDrugs,
      startDate: startDate,
      endDate: endDate,
    );

    try {
      if (kDebugMode) {
        print('Prescription à envoyer : ${prescription.toJson()}');
      }
      await Api().createPrescription(prescription);
      if (kDebugMode) {
        print(
            'Prescription créée avec ${prescription.drugs.length} médicaments');
        print('Date de début : ${prescription.startDate}');
        print('Date de fin : ${prescription.endDate}');
      }
      Fluttertoast.showToast(
          msg: "Prescription ajoutée au dossier du patient",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        drugs = [];
        selectedDrug = null;
        prescribedDrugs = [];
      });

      // Close the confirmation dialog and navigate back
      Navigator.of(context).pop(); // Close the dialog
      await Future.delayed(
          const Duration(milliseconds: 200)); // Ensure pop is processed
    } catch (e) {
      if (kDebugMode) {
        print('Erreur lors de la création de la prescription: $e');
      }
      showErrorDialog(e.toString(), context);
    }
  }

  Future<void> showConfirmationDialog() async {
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate
        .add(Duration(days: 2)); // endDate default 2 days after startDate

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Using StatefulBuilder to manage date status
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Confirmer la prescription'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Sélectionnez les dates de début et de fin pour la prescription.'),
                    SizedBox(height: 10),
                    Text('Date de début:'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            startDate = pickedDate;
                            endDate = pickedDate.add(
                                Duration(days: 2)); // Update endDate by default
                          });
                        }
                      },
                      child: Text(DateFormat('dd/MM/yyyy').format(startDate)),
                    ),
                    SizedBox(height: 10),
                    Text('Date de fin:'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: endDate,
                          firstDate:
                              startDate, // endDate cannot be before startDate
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                        }
                      },
                      child: Text(DateFormat('dd/MM/yyyy').format(endDate)),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Confirmer'),
                  onPressed: () {
                    if (appointmentSelected != null) {
                      createPrescription(
                          startDate, endDate, appointmentSelected!.patient.id);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  MedicalFolder? folder;

  Future<void> fetchPatientRecords(String patientId) async {
    try {
      final data = await Api().getPatientRecords(patientId);
      final medicalFolder = MedicalFolder.fromJson(data);

      setState(() => folder = medicalFolder);
    } catch (e) {
      showErrorDialog(e.toString(), context);
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
