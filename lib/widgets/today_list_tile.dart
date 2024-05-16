import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';

import 'icon_and_otted_lines.dart';

class TodayListTile extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;

  const TodayListTile({
    required this.appointment,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconAndDottedLines(),
          const SizedBox(
            width: 5.0,
          ),
          // List container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[350]!, Colors.white],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                title: Text(
                  "${appointment.patient.firstName.toUpperCase()} ${appointment.patient.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  appointment.motif,
                  style: const TextStyle(color: Colors.black87),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
