import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';
import 'package:soigne_moi_mobile/widgets/description_text_field.dart';
import 'package:soigne_moi_mobile/widgets/libelle_text_field.dart';

class LeaveMedicalReviewPage extends StatelessWidget {
  final HomeController controller;
  const LeaveMedicalReviewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('Laisser un avis médical'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[100]!, Colors.grey[400]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Avis du $formattedDate."),
              LibelleTextField(controller: controller),
              const SizedBox(height: 16.0),
              Expanded(
                flex: 5,
                child: DescriptionTextField(
                  controller: controller,
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  controller.submitMedicalReview();
                },
                child: Text(
                  'Envoyer l\'avis',
                  style: TextStyle(color: AppColors.accentColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
