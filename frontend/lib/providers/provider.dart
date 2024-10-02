import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/adopter/bloc/reminder/reminder_bloc.dart';
import 'package:fur_get_me_not/authentication/bloc/login/login_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';
import 'package:fur_get_me_not/authentication/repositories/login_repository.dart';
import 'package:fur_get_me_not/authentication/bloc/register/register_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/authentication/repositories/register_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/reminder/reminder_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_status/adoption_status_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_repository.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/adoption_form_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';

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
    final AdoptedPetRepository adoptedPetRepository = AdoptedPetRepository();

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
      BlocProvider<PetListBloc>( // Add PetListBloc here
        create: (context) => PetListBloc(petRepository: adoptedPetRepository),
      ),
    ];
  }
}
