import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/bloc/authentication/login_bloc.dart';
import 'package:fur_get_me_not/repositories/login_repository.dart';
import 'package:fur_get_me_not/bloc/authentication/register_bloc.dart';
import 'package:fur_get_me_not/repositories/pet_repository.dart';
import 'package:fur_get_me_not/repositories/register_repository.dart';
import 'package:fur_get_me_not/repositories/reminder_repository.dart';
import 'package:fur_get_me_not/repositories/adoption_status_repository.dart';
import 'package:fur_get_me_not/screens/pet_owner/pet_details_screen.dart';

final ReminderRepository reminderRepository = ReminderRepository();

class AppProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(loginRepository: LoginRepository()),
      ),
      BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(registerRepository: RegisterRepository()),
      ),
      BlocProvider<BottomNavCubit>(
        create: (context) => BottomNavCubit(),
      ),
      BlocProvider<AdoptionBrowseBloc>(
        create: (context) => AdoptionBrowseBloc(petRepository: PetRepository()),
      ),
      BlocProvider<PetDetailsBloc>(
        create: (context) => PetDetailsBloc(
          petRepository: context.read<PetRepository>(),
        ),
      ),
      BlocProvider<ReminderBloc>(
        create: (context) => ReminderBloc(reminderRepository),
      ),
      BlocProvider<AdoptionStatusBloc>(
        create: (context) => AdoptionStatusBloc(AdoptionStatusRepository()),
      ),
    ];
  }
}

