import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/review/review.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';

class LeaveMedicalReviewPage extends StatelessWidget {
  final ReviewController controller;
  const LeaveMedicalReviewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[300]!, Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: controller.libelleController,
                      cursorColor: AppColors.accentColor,
                      decoration: const InputDecoration(
                        labelText: 'Titre de l\'avis',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[300]!, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: controller.descriptionController,
                        maxLines: 5,
                        cursorColor: AppColors.accentColor,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          focusColor: AppColors.accentColor,
                          prefixIconColor: AppColors.accentColor,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
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
