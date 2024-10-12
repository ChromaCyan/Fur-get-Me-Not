import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class AdminChatListBloc extends Bloc<ChatEvent, ChatListState> {
  final AdminChatRepository adminChatRepository;

  AdminChatListBloc(this.adminChatRepository) : super(ChatListInitial()) {
    on<FetchChats>((event, emit) async {
      emit(ChatListLoading()); // Emit the loading state
      try {
        final chats = await adminChatRepository.fetchAdminChatList();
        emit(ChatListLoaded(chats)); // Emit the loaded state with chats
      } catch (e) {
        emit(ChatListError('Failed to load chats: $e'));
      }
    });
  }
}
