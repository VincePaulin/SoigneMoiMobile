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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 10),

          // Row with location icon and text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 4),
              Text(
                appointment!.patient.address.toString(),
                style: const TextStyle(color: Colors.black87, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Card
          Row(
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
                            'moti du séjour:',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          Text(
                            appointment.motif,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Row with 3 clickable CircleAvatars with icons inside
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[500]!, Colors.white],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.lightBlue, Colors.lightBlue[800]!],
                          ),
                          shape: BoxShape
                              .circle, // Forme du Container enfant (circulaire)
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[500]!, Colors.white],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.lightBlue, Colors.lightBlue[800]!],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.message,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[500]!, Colors.white],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.lightBlue, Colors.lightBlue[800]!],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
