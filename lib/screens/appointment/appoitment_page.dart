import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/screens/patient_folder/patient_folder_medical.dart';
import 'package:soigne_moi_mobile/screens/prescription/prescription_page.dart';
import 'package:soigne_moi_mobile/screens/review/review_view.dart';
import 'package:soigne_moi_mobile/widgets/appointment_icon_button.dart';
import 'package:soigne_moi_mobile/widgets/motif_card.dart';
import 'package:soigne_moi_mobile/widgets/patient_info.dart';

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
          PatientInfoWidget(appointment: appointment!),
          // Card
          MotifCard(appointment: appointment),
          const Spacer(),
          // Row with 3 clickable CircleAvatars with icons inside
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // prescription button
                AppointmentIconButton(
                  icon: MdiIcons.pill,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrescriptionPage(
                                controller: controller,
                              )),
                    );
                  },
                ),

                // button to leave a review
                AppointmentIconButton(
                    icon: MdiIcons.penPlus,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeaveMedicalReviewPage(
                                  controller: controller,
                                )),
                      );
                    }),

                // button to view the customer review file
                AppointmentIconButton(
                  icon: MdiIcons.folderSearch,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientMedicalFolder(
                                controller: controller,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
