abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class RegisterSubmitted extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role; // Use role instead of isAdopter
  final String sex; // Non-nullable
  final int age; // Non-nullable
  final String address; // Non-nullable

  RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role, // Update this
    required this.sex,
    required this.age,
    required this.address,
  });
}
