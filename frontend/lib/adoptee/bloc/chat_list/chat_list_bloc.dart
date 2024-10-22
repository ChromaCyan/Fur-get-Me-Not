import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class AdminChatListBloc extends Bloc<ChatEvent, ChatListState> {
  final AdminChatRepository adminChatRepository;

  AdminChatListBloc(this.adminChatRepository) : super(ChatListInitial()) {
    on<FetchChats>((event, emit) async {
      emit(ChatListLoading()); // Emit loading state
      try {
        final chats = await adminChatRepository.fetchAdminChatList();

        // Calculate unread messages count
        int unreadCount = chats.where((chat) => !chat.isRead).length;

        emit(ChatListLoaded(chats, unreadCount));
      } catch (e) {
        emit(ChatListError('Failed to load chats: $e'));
      }
    });
  }
}
