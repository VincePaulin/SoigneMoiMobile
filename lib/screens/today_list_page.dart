import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';
import 'package:soigne_moi_mobile/widgets/today_list_tile.dart';

import 'home/home.dart';

class TodayAppointmentPage extends StatelessWidget {
  final HomeController controller;

  const TodayAppointmentPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Column(
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
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: controller.todayAppointments.length,
            itemBuilder: (context, index) {
              final appointment = controller.todayAppointments[index];

              return TodayListTile(
                appointment: appointment,
                onTap: () => controller.selectAppointment(appointment),
              );
            },
          ),
        ),
      ],
    );
  }
}
