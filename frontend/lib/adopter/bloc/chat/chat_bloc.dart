import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_list_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final AdopterChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatMessageInitial()) {
    // Fetch messages event
    on<FetchMessages>((event, emit) async {
      emit(ChatMessageLoading());
      try {
        final messages = await chatRepository.fetchMessagesForUser(event.otherUserId);
        emit(ChatMessageLoaded(messages));
      } catch (e) {
        emit(ChatMessageError('Failed to load messages: $e'));
      }
    });

    // Send message event
    on<SendMessage>((event, emit) async {
      emit(ChatMessageLoading());
      try {
        await chatRepository.sendMessage(event.content, event.otherUserId);
        // Optionally, fetch messages again after sending a message
        final messages = await chatRepository.fetchMessagesForUser(event.otherUserId);
        emit(ChatMessageLoaded(messages));
      } catch (e) {
        emit(ChatMessageError('Failed to send message: $e'));
      }
    });
  }
}
