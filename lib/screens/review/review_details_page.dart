import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soigne_moi_mobile/model/review.dart';

class ReviewDetailsPage extends StatelessWidget {
  final ReviewModel review;

  const ReviewDetailsPage({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'Avis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Docteur: ${review.doctorName ?? 'N/A'}'),
            Text('Date: ${DateFormat('dd/MM/yyyy').format(review.date!)}'),
            SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(review.description),
          ],
        ),
      ),
    );
  }
}
