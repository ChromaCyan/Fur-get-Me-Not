import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fur_get_me_not/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading()); // Emit loading state while processing

    try {
      final success = await loginRepository.login(
        email: event.email,
        password: event.password,
      );

      if (success) {
        emit(LoginSuccess()); // Emit success state
      } else {
        emit(LoginFailure(error: 'Invalid email or password'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString())); // Emit failure on exception
    }
  }
}
