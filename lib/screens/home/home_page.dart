import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/appointment/appoitment_page.dart';
import 'package:soigne_moi_mobile/screens/today_list_page.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';
import 'package:soigne_moi_mobile/widgets/custom_app_bar.dart';
import 'package:soigne_moi_mobile/widgets/custom_navigation_bar.dart';

import 'home.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final bool itemSelected = controller.appointmentSelected != null;
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          doctor: controller.doctor!,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(120),
                    topRight: Radius.circular(120),
                  ),
                ),
              ),
            ),
            if (itemSelected)
              Positioned(
                top: 10,
                right: 20,
                child: GestureDetector(
                  onTap: () => controller.clearSelectAppointment(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ),
              ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: !itemSelected
                  ? TodayAppointmentPage(
                      controller: controller,
                    )
                  : _buildAppointmentPageRoute(context, controller),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          onHomePressed: () {
            // Action when home button is pressed
          },
          onSettingsPressed: () {
            // Action when the settings button is pressed
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentPageRoute(
      BuildContext context, HomeController controller) {
    return AppointmentPage(controller: controller);
  }
}
