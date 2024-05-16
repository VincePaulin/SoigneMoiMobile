import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';

class PatientInfoWidget extends StatelessWidget {
  final Appointment appointment;

  const PatientInfoWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final startDate = appointment.startDate;
    final endDate = appointment.endDate;
    final String formattedStartDate = DateFormat('dd/MM').format(startDate);
    final String formattedEndDate = DateFormat('dd/MM').format(endDate);

    return Column(
      children: [
        Text(
          "${appointment.patient.firstName.toUpperCase()} ${appointment.patient.name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 4),
            Text(
              appointment.patient.address.toString(),
              style: const TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Séjour du $formattedStartDate au $formattedEndDate",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
