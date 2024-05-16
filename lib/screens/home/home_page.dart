import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';
import 'package:soigne_moi_mobile/widgets/custom_app_bar.dart';
import 'package:soigne_moi_mobile/widgets/custom_navigation_bar.dart';
import 'package:soigne_moi_mobile/widgets/today_list_tile.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Format de la date
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    //print(controller.agenda?.appointments.length);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Aujourd'hui",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: controller.appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = controller.appointments[index];

                      return TodayListTile(
                        appointment: appointment,
                      );
                    },
                  ),
                ),
              ],
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
}
