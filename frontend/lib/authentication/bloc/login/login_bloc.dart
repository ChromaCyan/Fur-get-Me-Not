import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/authentication/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final result = await loginRepository.login(
        email: event.email,
        password: event.password,
      );

      if (result['success']) {
        final userType = result['userType'];
        emit(LoginSuccess(userType));
      } else {
        emit(LoginFailure(error: 'Invalid email or password'));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
