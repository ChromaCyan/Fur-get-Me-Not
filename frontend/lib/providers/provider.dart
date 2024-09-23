import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat/chat_bloc.dart'; // Import ChatBloc
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
import 'package:fur_get_me_not/repositories/chat_list_repository.dart';
import 'package:fur_get_me_not/repositories/chat_repository.dart';

class AppProviders {
  static List<BlocProvider> getProviders() {
    final PetRepository petRepository = PetRepository();
    final LoginRepository loginRepository = LoginRepository();
    final RegisterRepository registerRepository = RegisterRepository();
    final ReminderRepository reminderRepository = ReminderRepository();
    final AdoptionStatusRepository adoptionStatusRepository = AdoptionStatusRepository();
    final ChatListRepository chatListRepository = ChatListRepository();
    final ChatRepository chatRepository = ChatRepository(); // Initialize ChatRepository

    return [
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(loginRepository: loginRepository),
      ),
      BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(registerRepository: registerRepository),
      ),
      BlocProvider<BottomNavCubit>(
        create: (context) => BottomNavCubit(),
      ),
      BlocProvider<AdoptionBrowseBloc>(
        create: (context) => AdoptionBrowseBloc(petRepository: petRepository),
      ),
      BlocProvider<PetDetailsBloc>(
        create: (context) => PetDetailsBloc(petRepository: petRepository),
      ),
      BlocProvider<ReminderBloc>(
        create: (context) => ReminderBloc(reminderRepository),
      ),
      BlocProvider<AdoptionStatusBloc>(
        create: (context) => AdoptionStatusBloc(adoptionStatusRepository),
      ),
      BlocProvider<ChatListBloc>(
        create: (context) => ChatListBloc(chatListRepository),
      ),
      BlocProvider<ChatBloc>( // Pass only ChatRepository here
        create: (context) => ChatBloc(chatRepository),
      ),
    ];
  }
}
