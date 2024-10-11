class AdminPet {
  String? id;
  String name;
  String breed;
  String gender;
  int age;
  double height;
  double weight;
  String petImageUrl;
  String description;
  String specialCareInstructions;
  Adoptee adoptee;
  MedicalHistory medicalHistory;
  VaccineHistory vaccineHistory;
  String status; // Add the status field

  AdminPet({
    this.id,
    required this.name,
    required this.breed,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.petImageUrl,
    required this.description,
    required this.specialCareInstructions,
    required this.adoptee,
    required this.medicalHistory,
    required this.vaccineHistory,
    required this.status, // Status is now required
  });

  factory AdminPet.fromJson(Map<String, dynamic> json) {
    return AdminPet(
      id: json['_id'] ?? '', // Default to empty string if null
      name: json['name'] ?? 'Unknown', // Default value for name
      breed: json['breed'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      age: json['age'] ?? 0, // Default to 0 if null
      height: (json['height'] != null) ? json['height'].toDouble() : 0.0,
      weight: (json['weight'] != null) ? json['weight'].toDouble() : 0.0,
      petImageUrl: json['petImageUrl'] ?? '',
      description: json['description'] ?? 'No description available.',
      specialCareInstructions: json['specialCareInstructions'] ?? '',
      adoptee: Adoptee.fromJson(json['adopteeId'] ?? {}),
      medicalHistory: json['medicalHistory'] != null
          ? MedicalHistory.fromJson(json['medicalHistory'])
          : MedicalHistory(
        condition: 'No condition',
        diagnosisDate: DateTime.now(),
        treatment: 'N/A',
        recoveryStatus: 'Unknown',
      ),
      vaccineHistory: json['vaccineHistory'] != null
          ? VaccineHistory.fromJson(json['vaccineHistory'])
          : VaccineHistory(
        vaccineName: 'N/A',
        vaccinationDate: DateTime.now(),
      ),
      status: json['status'] ?? 'available', // Add status parsing
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
      'adopteeId': adoptee.toJson(),
      'medicalHistory': medicalHistory.toJson(),
      'vaccineHistory': vaccineHistory.toJson(),
      'status': status, // Add status serialization
    };
  }
}

class Adoptee {
  String id; // Assuming you want to keep the adoptee's ID
  String firstName;
  String lastName;

  Adoptee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Adoptee.fromJson(Map<String, dynamic> json) {
    return Adoptee(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class MedicalHistory {
  String condition;
  DateTime diagnosisDate;
  String treatment;
  String? veterinarianName;
  String? clinicName;
  DateTime? treatmentDate;
  String recoveryStatus;
  String? notes;

  MedicalHistory({
    required this.condition,
    required this.diagnosisDate,
    required this.treatment,
    this.veterinarianName,
    this.clinicName,
    this.treatmentDate,
    required this.recoveryStatus,
    this.notes,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) {
    return MedicalHistory(
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

class VaccineHistory {
  String vaccineName;
  DateTime vaccinationDate;
  DateTime? nextDueDate;
  String? veterinarianName;
  String? clinicName;
  String? notes;

  VaccineHistory({
    required this.vaccineName,
    required this.vaccinationDate,
    this.nextDueDate,
    this.veterinarianName,
    this.clinicName,
    this.notes,
  });

  factory VaccineHistory.fromJson(Map<String, dynamic> json) {
    return VaccineHistory(
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
