class ReviewModel {
  final String title;
  final String description;
  final String? doctorName;
  final DateTime? date;
  final String? patientId;

  ReviewModel({
    required this.title,
    required this.description,
    this.doctorName,
    this.date,
    this.patientId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      title: json['libelle'] ?? '',
      description: json['description'] ?? '',
      doctorName: json['doctor'] ?? '',
      date: DateTime.parse(json['date'] ?? ''),
      patientId: json['patient_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'libelle': title,
      'description': description,
      'patient': patientId,
    };
  }
}
