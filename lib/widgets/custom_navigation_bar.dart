import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/utils/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function() onHomePressed;
  final Function() onSettingsPressed;

  const CustomBottomNavigationBar({
    super.key,
    required this.onHomePressed,
    required this.onSettingsPressed,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[400]!, Colors.white],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.view_agenda, color: AppColors.primaryColor),
              onPressed: widget.onHomePressed,
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.grey),
              onPressed: widget.onSettingsPressed,
            ),
          ],
        ),
      ),
    );
  }
}
