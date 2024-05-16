import 'package:flutter/material.dart';

class IconAndDottedLines extends StatelessWidget {
  const IconAndDottedLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White circular icon
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.grey[400]!, Colors.white],
            ),
          ),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey[400]!, Colors.white],
              ),
              shape: BoxShape.circle,
            ),
          ), // Placeholder icon
        ),
        // Vertical dotted lines
        Column(
          children: List.generate(
            // Number of small lines
            5,
            (index) => Container(
              width: 1,
              height: 5,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(vertical: 3),
            ),
          ),
        ),
      ],
    );
  }
}
