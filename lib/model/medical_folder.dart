import 'package:soigne_moi_mobile/model/prescription.dart';
import 'package:soigne_moi_mobile/model/review.dart';

class MedicalFolder {
  final List<Prescription> prescriptions;
  final List<ReviewModel> reviews;

  MedicalFolder({
    required this.prescriptions,
    required this.reviews,
  });

  factory MedicalFolder.fromJson(Map<String, dynamic> json) {
    return MedicalFolder(
      prescriptions: (json['prescriptions'] as List<dynamic>)
          .map((item) => Prescription.fromJson(item))
          .toList(),
      reviews: (json['avis'] as List<dynamic>)
          .map((item) => ReviewModel.fromJson(item))
          .toList(),
    );
  }
}
