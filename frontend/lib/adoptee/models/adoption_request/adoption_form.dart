class AdminAdoptionForm {
  final String petId; // Add this field
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zipCode;
  final String residenceType;
  final String ownRent; // Change to String
  final bool landlordAllowsPets;
  final bool ownedPetsBefore;
  final List<String> petTypesOwned; // Change to List<String>
  final String petPreference;
  final String preferredSize;
  final String agePreference;
  final int hoursAlone; // Change to int
  final String activityLevel;
  final List<int> childrenAges; // Change to List<int>
  final String carePlan;
  final String whatIfNoLongerKeep;
  final bool longTermCommitment;

  AdminAdoptionForm({
    required this.petId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.residenceType,
    required this.ownRent,
    required this.landlordAllowsPets,
    required this.ownedPetsBefore,
    required this.petTypesOwned,
    required this.petPreference,
    required this.preferredSize,
    required this.agePreference,
    required this.hoursAlone,
    required this.activityLevel,
    required this.childrenAges,
    required this.carePlan,
    required this.whatIfNoLongerKeep,
    required this.longTermCommitment,
  });

  // fromJson method
  factory AdminAdoptionForm.fromJson(Map<String, dynamic> json) {
    return AdminAdoptionForm(
      petId: json['petId'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      zipCode: json['zipCode'],
      residenceType: json['residenceType'],
      ownRent: json['ownRent'],
      landlordAllowsPets: json['landlordAllowsPets'],
      ownedPetsBefore: json['ownedPetsBefore'],
      petTypesOwned: List<String>.from(json['petTypesOwned'] ?? []),
      petPreference: json['petPreference'],
      preferredSize: json['preferredSize'],
      agePreference: json['agePreference'],
      hoursAlone: json['hoursAlone'],
      activityLevel: json['activityLevel'],
      childrenAges: List<int>.from(json['childrenAges'] ?? []),
      carePlan: json['carePlan'],
      whatIfNoLongerKeep: json['whatIfNoLongerKeep'],
      longTermCommitment: json['longTermCommitment'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'petId': petId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'zipCode': zipCode,
      'residenceType': residenceType,
      'ownRent': ownRent,
      'landlordAllowsPets': landlordAllowsPets,
      'ownedPetsBefore': ownedPetsBefore,
      'petTypesOwned': petTypesOwned,
      'petPreference': petPreference,
      'preferredSize': preferredSize,
      'agePreference': agePreference,
      'hoursAlone': hoursAlone,
      'activityLevel': activityLevel,
      'childrenAges': childrenAges,
      'carePlan': carePlan,
      'whatIfNoLongerKeep': whatIfNoLongerKeep,
      'longTermCommitment': longTermCommitment,
    };
  }
}