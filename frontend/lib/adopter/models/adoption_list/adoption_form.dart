class AdoptionForm {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zipCode;

  AdoptionForm({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
  });
}
//
// class AdoptionFormModel {
//   final String fullName;
//   final String email;
//   final String phone;
//   final String address;
//   final String city;
//   final String zipCode;
//   final String residenceType;
//   final bool ownRent;
//   final bool landlordAllowsPets;
//   final bool ownedPetsBefore;
//   final String petTypesOwned;
//   final String petPreference;
//   final String preferredSize;
//   final String agePreference;
//   final String hoursAlone;
//   final String activityLevel;
//   final String childrenAges;
//   final String carePlan;
//   final String whatIfNoLongerKeep;
//   final bool longTermCommitment;
//
//   AdoptionFormModel({
//     required this.fullName,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.city,
//     required this.zipCode,
//     required this.residenceType,
//     required this.ownRent,
//     required this.landlordAllowsPets,
//     required this.ownedPetsBefore,
//     required this.petTypesOwned,
//     required this.petPreference,
//     required this.preferredSize,
//     required this.agePreference,
//     required this.hoursAlone,
//     required this.activityLevel,
//     required this.childrenAges,
//     required this.carePlan,
//     required this.whatIfNoLongerKeep,
//     required this.longTermCommitment,
//   });
//
//   AdoptionFormModel copyWith({
//     String? fullName,
//     String? email,
//     String? phone,
//     String? address,
//     String? city,
//     String? zipCode,
//     String? residenceType,
//     bool? ownRent,
//     bool? landlordAllowsPets,
//     bool? ownedPetsBefore,
//     String? petTypesOwned,
//     String? petPreference,
//     String? preferredSize,
//     String? agePreference,
//     String? hoursAlone,
//     String? activityLevel,
//     String? childrenAges,
//     String? carePlan,
//     String? whatIfNoLongerKeep,
//     bool? longTermCommitment,
//   }) {
//     return AdoptionFormModel(
//       fullName: fullName ?? this.fullName,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       address: address ?? this.address,
//       city: city ?? this.city,
//       zipCode: zipCode ?? this.zipCode,
//       residenceType: residenceType ?? this.residenceType,
//       ownRent: ownRent ?? this.ownRent,
//       landlordAllowsPets: landlordAllowsPets ?? this.landlordAllowsPets,
//       ownedPetsBefore: ownedPetsBefore ?? this.ownedPetsBefore,
//       petTypesOwned: petTypesOwned ?? this.petTypesOwned,
//       petPreference: petPreference ?? this.petPreference,
//       preferredSize: preferredSize ?? this.preferredSize,
//       agePreference: agePreference ?? this.agePreference,
//       hoursAlone: hoursAlone ?? this.hoursAlone,
//       activityLevel: activityLevel ?? this.activityLevel,
//       childrenAges: childrenAges ?? this.childrenAges,
//       carePlan: carePlan ?? this.carePlan,
//       whatIfNoLongerKeep: whatIfNoLongerKeep ?? this.whatIfNoLongerKeep,
//       longTermCommitment: longTermCommitment ?? this.longTermCommitment,
//     );
//   }
// }
