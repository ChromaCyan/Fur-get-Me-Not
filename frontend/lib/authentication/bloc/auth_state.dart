abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String userId;
  final String role; // Capture the role

  AuthLoginSuccess(this.userId, this.role); // Update constructor
}

class AuthRegisterSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
