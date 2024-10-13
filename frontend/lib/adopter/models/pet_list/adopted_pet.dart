class AdoptedPet {
  String id;
  String name;
  String breed;
  String gender;
  int age;
  double height;
  double weight;
  String petImageUrl;
  String description;
  String specialCareInstructions;
  AdoptedMedicalHistory medicalHistory;
  AdoptedVaccineHistory vaccineHistory;
  String status;

  AdoptedPet({
    required this.id,
    required this.name,
    required this.breed,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.petImageUrl,
    required this.description,
    required this.specialCareInstructions,
    required this.medicalHistory,
    required this.vaccineHistory,
    required this.status,
  });

  factory AdoptedPet.fromJson(Map<String, dynamic> json) {
    return AdoptedPet(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      breed: json['breed'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      age: json['age'] ?? 0,
      height: double.tryParse(json['height']?.toString() ?? '0') ?? 0.0, // Convert to double safely
      weight: double.tryParse(json['weight']?.toString() ?? '0') ?? 0.0, // Convert to double safely
      petImageUrl: json['petImageUrl'] ?? '',
      description: json['description'] ?? 'No description available.',
      specialCareInstructions: json['specialCareInstructions'] ?? '',
      medicalHistory: json['medicalHistory'] != null
          ? AdoptedMedicalHistory.fromJson(json['medicalHistory'])
          : AdoptedMedicalHistory(
        condition: 'No condition',
        diagnosisDate: DateTime.now(),
        treatment: 'N/A',
        recoveryStatus: 'Unknown',
      ),
      vaccineHistory: json['vaccineHistory'] != null
          ? AdoptedVaccineHistory.fromJson(json['vaccineHistory'])
          : AdoptedVaccineHistory(
        vaccineName: 'N/A',
        vaccinationDate: DateTime.now(),
      ),
      status: json['status'] ?? 'available',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'breed': breed,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'petImageUrl': petImageUrl,
      'description': description,
      'specialCareInstructions': specialCareInstructions,
      'medicalHistory': medicalHistory.toJson(),
      'vaccineHistory': vaccineHistory.toJson(),
      'status': status,
    };
  }
}

class AdoptedMedicalHistory {
  String condition;
  DateTime diagnosisDate;
  String treatment;
  String? veterinarianName;
  String? clinicName;
  DateTime? treatmentDate;
  String recoveryStatus;
  String? notes;

  AdoptedMedicalHistory({
    required this.condition,
    required this.diagnosisDate,
    required this.treatment,
    this.veterinarianName,
    this.clinicName,
    this.treatmentDate,
    required this.recoveryStatus,
    this.notes,
  });

  factory AdoptedMedicalHistory.fromJson(Map<String, dynamic> json) {
    return AdoptedMedicalHistory(
      condition: json['condition'],
      diagnosisDate: DateTime.parse(json['diagnosisDate']),
      treatment: json['treatment'],
      veterinarianName: json['veterinarianName'],
      clinicName: json['clinicName'],
      treatmentDate: json['treatmentDate'] != null
          ? DateTime.parse(json['treatmentDate'])
          : null,
      recoveryStatus: json['recoveryStatus'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition,
      'diagnosisDate': diagnosisDate.toIso8601String(),
      'treatment': treatment,
      'veterinarianName': veterinarianName,
      'clinicName': clinicName,
      'treatmentDate': treatmentDate?.toIso8601String(),
      'recoveryStatus': recoveryStatus,
      'notes': notes,
    };
  }
}

class AdoptedVaccineHistory {
  String vaccineName;
  DateTime vaccinationDate;
  DateTime? nextDueDate;
  String? veterinarianName;
  String? clinicName;
  String? notes;

  AdoptedVaccineHistory({
    required this.vaccineName,
    required this.vaccinationDate,
    this.nextDueDate,
    this.veterinarianName,
    this.clinicName,
    this.notes,
  });

  factory AdoptedVaccineHistory.fromJson(Map<String, dynamic> json) {
    return AdoptedVaccineHistory(
      vaccineName: json['vaccineName'],
      vaccinationDate: DateTime.parse(json['vaccinationDate']),
      nextDueDate: json['nextDueDate'] != null
          ? DateTime.parse(json['nextDueDate'])
          : null,
      veterinarianName: json['veterinarianName'],
      clinicName: json['clinicName'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccineName': vaccineName,
      'vaccinationDate': vaccinationDate.toIso8601String(),
      'nextDueDate': nextDueDate?.toIso8601String(),
      'veterinarianName': veterinarianName,
      'clinicName': clinicName,
      'notes': notes,
    };
  }
}
