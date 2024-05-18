import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/model/medical_folder.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';

class PatientMedicalFolder extends StatefulWidget {
  final HomeController controller;

  const PatientMedicalFolder({Key? key, required this.controller})
      : super(key: key);

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
              title: Text(review.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description: ${review.description}'),
                  Text('Docteur: ${review.doctorName ?? 'N/A'}'),
                  Text('Date: ${review.date?.toIso8601String()}'),
                ],
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
                  'Prescription du ${prescription.startDate.toIso8601String()} au ${prescription.endDate.toIso8601String()}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...prescription.drugs
                      .map((drug) => Text('${drug.name} - ${drug.dosage}')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
