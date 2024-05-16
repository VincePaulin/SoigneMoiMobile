import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';

class MotifCard extends StatelessWidget {
  final Appointment appointment;

  const MotifCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[300],
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Motif du séjour:',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  Text(
                    appointment.motif,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
