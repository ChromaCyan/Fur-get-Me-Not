import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class AdminChatListBloc extends Bloc<ChatEvent, ChatState> {
  final AdminChatListRepository adminChatRepository;

  AdminChatListBloc(this.adminChatRepository) : super(ChatInitial()) {
    on<FetchChats>((event, emit) async {
      emit(ChatLoading());
      try {
        final chats = await adminChatRepository.fetchAllChats();
        emit(ChatLoaded(chats));
      } catch (e) {
        emit(ChatError('Failed to load chats: $e'));
      }
    });
  }
}
