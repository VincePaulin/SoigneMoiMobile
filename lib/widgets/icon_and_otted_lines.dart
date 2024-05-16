import 'package:flutter/material.dart';

class IconAndDottedLines extends StatelessWidget {
  const IconAndDottedLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White circular icon
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child:
              const Icon(Icons.circle, color: Colors.grey), // Placeholder icon
        ),
        // Vertical dotted lines
        Column(
          children: List.generate(
            // Number of small lines
            5,
            (index) => Container(
              width: 1,
              height: 5,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 3),
            ),
          ),
        ),
      ],
    );
  }
}
