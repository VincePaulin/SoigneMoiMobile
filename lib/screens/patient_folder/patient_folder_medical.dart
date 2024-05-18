import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/screens/review/review_details_page.dart';
import 'package:soigne_moi_mobile/screens/prescription/prescription_details_page.dart';

class PatientMedicalFolder extends StatefulWidget {
  final HomeController controller;

  const PatientMedicalFolder({super.key, required this.controller});

  @override
  State<PatientMedicalFolder> createState() => _PatientMedicalFolderState();
}

class _PatientMedicalFolderState extends State<PatientMedicalFolder> {
  @override
  void initState() {
    super.initState();
    widget.controller.fetchPatientRecords(
        widget.controller.appointmentSelected!.patient.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier Médical du Patient'),
      ),
      body: widget.controller.folder == null
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Avis'),
                      Tab(text: 'Prescriptions'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildAvisList(),
                        _buildPrescriptionList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAvisList() {
    final avis = widget.controller.folder?.reviews ?? [];
    if (avis.isEmpty) {
      return Center(child: Text('Aucune donnée trouvée'));
    }
    return ListView.builder(
      itemCount: avis.length,
      itemBuilder: (context, index) {
        final review = avis[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewDetailsPage(review: review),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(review.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${review.description}'),
                    Text('Docteur: ${review.doctorName ?? 'N/A'}'),
                    Text(
                        'Date: ${DateFormat('dd/MM/yyyy').format(review.date!)}'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrescriptionList() {
    final prescriptions = widget.controller.folder?.prescriptions ?? [];
    if (prescriptions.isEmpty) {
      return Center(child: Text('Aucune donnée trouvée'));
    }
    return ListView.builder(
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final prescription = prescriptions[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              final updatedPrescription = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrescriptionDetailsPage(
                    prescription: prescription,
                    controller: widget.controller,
                  ),
                ),
              ).then((_) {
                widget.controller.fetchPatientRecords(widget
                    .controller.appointmentSelected!.patient.id
                    .toString());
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                    'Prescription du ${DateFormat('dd/MM/yyyy').format(prescription.startDate)} au ${DateFormat('dd/MM/yyyy').format(prescription.endDate)}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...prescription.drugs
                        .map((drug) => Text('${drug.name} - ${drug.dosage}')),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
