class Pet {
  final String id; // MongoDB uses `_id`
  final String name;
  final String breed;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String petImageUrl;
  final String description;
  final String specialCareInstructions;
  final Adoptee adopteeId;

  Pet({
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
    required this.adopteeId,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'], // MongoDB uses `_id`
      name: json['name'],
      breed: json['breed'],
      gender: json['gender'],
      age: json['age'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      petImageUrl: json['petImageUrl'],
      description: json['description'],
      specialCareInstructions: json['specialCareInstructions'] ?? '', // Provide default
      adopteeId: Adoptee.fromJson(json['adopteeId']), // Parse Adoptee
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
      'adopteeId': adopteeId.toJson(), // Convert Adoptee to JSON
    };
  }
}

// Adoptee class to represent the adopter's details
class Adoptee {
  final String id;
  final String firstName;
  final String lastName;

  Adoptee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Adoptee.fromJson(Map<String, dynamic> json) {
    return Adoptee(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
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
