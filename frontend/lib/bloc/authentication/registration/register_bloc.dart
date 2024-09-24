// lib/bloc/authentication/register_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/repositories/authentication/register_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmitted) {
      yield RegisterLoading();
      try {
        await registerRepository.registerUser(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );
        yield RegisterSuccess();
      } catch (e) {
        yield RegisterFailure(error: e.toString());
      }
    }
  }
}
