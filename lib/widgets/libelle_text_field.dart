import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';

class LibelleTextField extends StatelessWidget {
  final HomeController controller;

  const LibelleTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
