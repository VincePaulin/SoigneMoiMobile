// Prescription model
class Prescription {
  final List<Drug> drugs;
  final DateTime startDate;
  DateTime endDate;

  Prescription({
    required this.drugs,
    required this.startDate,
    required this.endDate,
  });

  // Copy constructor
  Prescription.copy(Prescription prescription)
      : drugs = List<Drug>.from(prescription.drugs),
        startDate = prescription.startDate,
        endDate = prescription.endDate;

  // Method to update the end date of the prescription
  void updateEndDate(DateTime newEndDate) {
    endDate = newEndDate;
  }

  // Method to convert Prescription from JSON
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      drugs: (json['drugs'] as List<dynamic>)
          .map((drugJson) => Drug.fromJson(drugJson))
          .toList(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  // Method to convert Prescription to JSON
  Map<String, dynamic> toJson() {
    return {
      'drugs': drugs.map((drug) => drug.toJson()).toList(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}

// Drug model
class Drug {
  final String drug;
  final String dosage;

  Drug({
    required this.drug,
    required this.dosage,
  });

  // Method to convert Drug from JSON
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      drug: json['drug'] as String,
      dosage: json['dosage'] as String,
    );
  }

  // Method to convert Drug to JSON
  Map<String, dynamic> toJson() {
    return {
      'drug': drug,
      'dosage': dosage,
    };
  }
}
