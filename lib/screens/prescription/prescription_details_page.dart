import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/api/services/api_service.dart';
import 'package:soigne_moi_mobile/model/prescription.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';

class PrescriptionDetailsPage extends StatefulWidget {
  final Prescription prescription;
  final HomeController controller;

  const PrescriptionDetailsPage({
    super.key,
    required this.prescription,
    required this.controller,
  });

  @override
  State<PrescriptionDetailsPage> createState() =>
      _PrescriptionDetailsPageState();
}

class _PrescriptionDetailsPageState extends State<PrescriptionDetailsPage> {
  late DateTime _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _selectedEndDate = widget.prescription.endDate;
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prescription',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
                'Date de début: ${DateFormat('dd/MM/yyyy').format(widget.prescription.startDate)}'),
            Text(
                'Date de fin: ${DateFormat('dd/MM/yyyy').format(_selectedEndDate)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: Text('Modifier la date de fin'),
            ),
            const SizedBox(height: 20),
            Text(
              'Médicaments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.prescription.drugs
                .map((drug) => Text('${drug.name} - ${drug.dosage}')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                widget.controller
                    .modifyEndDate(widget.prescription.id!, _selectedEndDate);

                Navigator.pop(context, widget.prescription);
              },
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}
