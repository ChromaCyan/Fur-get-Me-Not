abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String userId;
  final String token;
  final String role;

  AuthLoginSuccess(this.userId, this.token, this.role);
}

class AuthOtpSent extends AuthState {
  final String email;

  AuthOtpSent(this.email);
}

class AuthOtpVerificationSuccess extends AuthState {
  AuthOtpVerificationSuccess();
}

class AuthOtpVerificationFailure extends AuthState {
  final String error;

  AuthOtpVerificationFailure({required this.error});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
