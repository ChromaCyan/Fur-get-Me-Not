import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_management/pet_management_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_form/adoption_form_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_status/adoption_status_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat_list/chat_list_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/adoption_browse/adoption_browse_bloc.dart';
import 'package:fur_get_me_not/adopter/bloc/nav_bar/nav_cubit.dart';
import 'package:fur_get_me_not/authentication/bloc/auth_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/adoption_request/adoption_request_bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/adoption_request/adoption_request_repository.dart';
import 'package:fur_get_me_not/adoptee/repositories/pet_management/admin_pet_repository.dart';
import 'package:fur_get_me_not/authentication/repositories/auth_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/pet_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_status/adoption_status_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'package:fur_get_me_not/adopter/repositories/adoption_list/adoption_form_repository.dart';
import 'package:fur_get_me_not/adopter/bloc/pet_list/pet_list_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';
import 'package:fur_get_me_not/adoptee/bloc/pet_details/pet_details_bloc.dart';
import 'package:fur_get_me_not/adoptee/bloc/chat/chat_bloc.dart';
import 'package:fur_get_me_not/adopter/repositories/pet_list/adopted_pet_repository.dart';
import 'package:fur_get_me_not/adopter/bloc/adopted_pet_details/adopted_pet_details_bloc.dart';


class AppProviders {
  static List<BlocProvider> getProviders() {
    final PetRepository petRepository = PetRepository();
    final AuthRepository loginRepository = AuthRepository();
    final AdoptedPetRepository adoptedPetRepository = AdoptedPetRepository();
    final AdoptionFormRepository adoptionFormRepository = AdoptionFormRepository();

    final AdminPetRepository adminPetRepository = AdminPetRepository();
    final AdoptionStatusRepository adoptionStatusRepository = AdoptionStatusRepository();
    final AdoptionRequestRepository adoptionRequestRepository = AdoptionRequestRepository();

    // New Chat Repositories
    final AdopterChatRepository adopterChatRepository = AdopterChatRepository();
    final AdopterChatRepository adopterChatListRepository = AdopterChatRepository();
    final AdminChatRepository adminChatRepository =AdminChatRepository();
    final AdminChatRepository adminChatListRepository = AdminChatRepository();

    return [
      //Login and Nav
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository: loginRepository),
      ),
      BlocProvider<BottomNavCubit>(
        create: (context) => BottomNavCubit(),
      ),

      //Adoption Process
      BlocProvider<AdoptionBrowseBloc>(
        create: (context) => AdoptionBrowseBloc(petRepository: petRepository),
      ),
      BlocProvider<PetDetailsBloc>(
        create: (context) => PetDetailsBloc(petRepository: petRepository),
      ),
      BlocProvider<AdopteePetDetailsBloc>(
        create: (context) => AdopteePetDetailsBloc(petRepository: adminPetRepository),
      ),
      BlocProvider<AdoptionStatusBloc>(
        create: (context) => AdoptionStatusBloc(adoptionStatusRepository: adoptionStatusRepository),
      ),
      BlocProvider<AdoptionBloc>(
        create: (context) => AdoptionBloc(adoptionFormRepository),
      ),
      BlocProvider<AdminAdoptionBloc>(
        create: (BuildContext context) => AdminAdoptionBloc(adoptionRequestRepository),
      ),
      BlocProvider<PetManagementBloc>(
        create: (context) => PetManagementBloc(petRepository: adminPetRepository),
      ),
      BlocProvider<AdoptionRequestBloc>(
        create: (context) => AdoptionRequestBloc(repository: adoptionRequestRepository),
      ),
      BlocProvider<PetListBloc>(
        create: (context) => PetListBloc(petRepository: adoptedPetRepository),
      ),
      BlocProvider<AdoptedPetDetailsBloc>(
        create: (context) => AdoptedPetDetailsBloc(petRepository: adoptedPetRepository),
      ),
      //Chat List
      BlocProvider<AdminChatListBloc>(
        create: (context) => AdminChatListBloc(adminChatListRepository),
      ),
       BlocProvider<AdminChatBloc>(
        create: (context) => AdminChatBloc(adminChatRepository),
      ),
      BlocProvider<ChatListBloc>(
        create: (context) => ChatListBloc(adopterChatRepository),
      ),
      BlocProvider<ChatBloc>(
        create: (BuildContext context) => ChatBloc(adopterChatRepository),
      ),

            
      // Uncomment if ReminderBloc is needed
      // BlocProvider<ReminderBloc>(
      //   create: (context) => ReminderBloc(reminderRepository),
      // ),
      
      // BlocProvider<ChatBloc>(
      //   create: (context) => ChatBloc(chatListRepository),
      // ),
    ];
  }
}
