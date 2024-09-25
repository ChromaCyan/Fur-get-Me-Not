import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/bloc/adoptee/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/bloc/adoptee/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/chat/chat_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/bloc/adopter/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/bloc/adopter/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/bloc/authentication/login/login_bloc.dart';
import 'package:fur_get_me_not/bloc/adoptee/adoption_request/adoption_request_bloc.dart';
import 'package:fur_get_me_not/repositories/adoptee/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/repositories/adoptee/pet_management/admin_pet_repository.dart';
import 'package:fur_get_me_not/repositories/authentication/login_repository.dart';
import 'package:fur_get_me_not/bloc/authentication/registration/register_bloc.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/repositories/authentication/register_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/reminder/reminder_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_status/adoption_status_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/chat/chat_list_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/chat/chat_repository.dart';
import 'package:fur_get_me_not/repositories/adoptee/chat/admin_chat_list_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_list/adoption_form_repository.dart';
import 'package:fur_get_me_not/repositories/adopters/adoption_list/pet_repository.dart';

class AppProviders {
  static List<BlocProvider> getProviders() {
    final PetRepository petRepository = PetRepository();
    final LoginRepository loginRepository = LoginRepository();
    final RegisterRepository registerRepository = RegisterRepository();
    final ReminderRepository reminderRepository = ReminderRepository();
    final ChatListRepository chatListRepository = ChatListRepository();
    final ChatRepository chatRepository = ChatRepository();
    final AdoptionFormRepository adoptionFormRepository = AdoptionFormRepository();
    final AdminChatListRepository adminChatListRepository = AdminChatListRepository();
    final AdminPetRepository adminPetRepository = AdminPetRepository();
    final AdoptionStatusRepository adoptionStatusRepository = AdoptionStatusRepository();
    final AdoptionRequestRepository adoptionRequestRepository = AdoptionRequestRepository();

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
        create: (context) => AdoptionStatusBloc(adoptionStatusRepository: adoptionStatusRepository),
      ),
      BlocProvider<ChatListBloc>(
        create: (context) => ChatListBloc(chatListRepository),
      ),
      BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(chatRepository),
      ),
      BlocProvider<AdoptionBloc>(
        create: (context) => AdoptionBloc(adoptionFormRepository),
      ),
      BlocProvider<AdminChatListBloc>(
        create: (context) => AdminChatListBloc(adminChatListRepository),
      ),
      BlocProvider<PetManagementBloc>(
        create: (context) => PetManagementBloc(petRepository: adminPetRepository),
      ),
      BlocProvider<AdoptionRequestBloc>(
        create: (context) => AdoptionRequestBloc(repository: adoptionRequestRepository),
      ),
    ];
  }
}
