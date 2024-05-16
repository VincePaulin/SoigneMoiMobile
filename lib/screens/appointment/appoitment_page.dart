import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';

class AppointmentPage extends StatelessWidget {
  final HomeController controller;
  const AppointmentPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final appointment = controller.appointmentSelected;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nom en gras
          Text(
            "${appointment?.patient.firstName.toUpperCase()} ${appointment?.patient.name}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Row with location icon and text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8),
              Text(
                appointment!.patient.address.toString(),
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[300],
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                appointment.motif,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Row with 3 clickable CircleAvatars with icons inside
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  // Action
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.medical_services),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Action
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.message),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Action
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.check),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
