// Prescription model
class Prescription {
  final int patientId;
  final List<Drug> drugs;
  final DateTime startDate;
  DateTime endDate;

  Prescription({
    required this.patientId,
    required this.drugs,
    required this.startDate,
    required this.endDate,
  });

  // Copy constructor
  Prescription.copy(Prescription prescription)
      : patientId = prescription.patientId,
        drugs = List<Drug>.from(prescription.drugs),
        startDate = prescription.startDate,
        endDate = prescription.endDate;

  // Method to update the end date of the prescription
  void updateEndDate(DateTime newEndDate) {
    endDate = newEndDate;
  }

  // Method to convert Prescription from JSON
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      patientId: json['patientId'],
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
      'patient_id': patientId,
      'drugs': drugs.map((drug) => drug.toJson()).toList(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}

// Drug model
class Drug {
  final String name;
  final String dosage;

  Drug({
    required this.name,
    required this.dosage,
  });

  // Method to convert Drug from JSON
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json['name'] as String,
      dosage: json['dosage'] as String,
    );
  }

  // Method to convert Drug to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
    };
  }
}
