// lib/models/pet.dart

class Pet {
  final String id;
  final String name;
  final String breed;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String petImageUrl;
  final String description;
  final String specialCareInstructions;

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
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      breed: json['breed'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      petImageUrl: json['petImageUrl'],
      description: json['description'],
      specialCareInstructions: json['specialCareInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'petImageUrl': petImageUrl,
      'description': description,
      'specialCareInstructions': specialCareInstructions,
    };
  }
}
