import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/api/services/api_service.dart';
import 'package:soigne_moi_mobile/model/agenda.dart';
import 'package:soigne_moi_mobile/model/review.dart';
import 'package:soigne_moi_mobile/screens/review/review_view.dart';

class Review extends StatefulWidget {
  final String matricule;
  final Appointment appointment;
  const Review({super.key, required this.matricule, required this.appointment});

  @override
  ReviewController createState() => ReviewController();
}

class ReviewController extends State<Review> {
  TextEditingController libelleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> submitMedicalReview() async {
    String libelle = libelleController.text;
    String description = descriptionController.text;
    final patientId = widget.appointment.patient.id;

    final review = ReviewModel(
        title: libelle,
        description: description,
        patientId: patientId.toString());

    await Api().createMedicalReview(review);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Avis envoyé'),
          content: Text('Votre avis médical a été envoyé avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    libelleController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (loading != true) {
      return LeaveMedicalReviewPage(
        controller: this,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
