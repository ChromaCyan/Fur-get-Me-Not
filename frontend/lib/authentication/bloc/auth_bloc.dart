import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(email: event.email, password: event.password);
      if (result['success']) {
        emit(AuthLoginSuccess(result['userId'],result['token'], result['role']));
      } else {
        emit(AuthFailure(error: 'Invalid email or password'));
      }
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        role: event.role,
        sex: event.sex,
        age: event.age,
        address: event.address,
      );
      emit(AuthRegisterSuccess());
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }
}
