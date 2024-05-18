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
            // Container with pointed top corners (blue top)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            // Container with grey background positioned slightly lower
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[100]!, Colors.grey[400]!],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            if (itemSelected)
              Positioned(
                top: 15,
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
                      size: 15,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              bottom: 70,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: !itemSelected
                    ? TodayAppointmentPage(
                        controller: controller,
                      )
                    : _buildAppointmentPageRoute(context, controller),
              ),
            ),

            // An unfinished navigator bar

            // Positioned(
            //     bottom: 0,
            //     right: 0,
            //     left: 0,
            //     child: CustomBottomNavigationBar(
            //       onHomePressed: () {
            //         // Action when home button is pressed
            //       },
            //       onSettingsPressed: () {
            //         // Action when the settings button is pressed
            //       },
            //     ))
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentPageRoute(
      BuildContext context, HomeController controller) {
    return AppointmentPage(controller: controller);
  }
}
