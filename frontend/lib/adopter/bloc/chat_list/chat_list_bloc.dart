import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat_list.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatEvent, ChatState> {
  final AdopterChatRepository chatRepository;

  ChatListBloc(this.chatRepository) : super(ChatInitial()) {
    on<FetchChats>((event, emit) async {
      emit(ChatLoading());
      try {
        final chats = await chatRepository.fetchAdopterChatList();
        emit(ChatLoaded(chats));
      } catch (e) {
        emit(ChatError('Failed to load chats: $e'));
      }
    });
  }
}
