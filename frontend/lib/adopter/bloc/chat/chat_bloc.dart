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
        final messages = await chatRepository.fetchMessagesForUser(
            event.otherUserId);
        emit(ChatMessageLoaded(messages));
      } catch (e) {
        emit(ChatMessageError('Failed to load messages: $e'));
      }
    });

    on<SendMessage>((event, emit) async* {
      try {
        emit(ChatMessageLoading());

        // First, attempt to send message using existing chat
        final chatId = await chatRepository.sendMessage(
            event.content,
            event.otherUserId
        );

        // If successful, fetch messages and emit loaded state
        final messages = await chatRepository.fetchMessagesForUser(event.otherUserId);
        emit(ChatMessageLoaded(messages));

      } catch (e) {
        print('Failed to send message, creating new chat...');
        try {
          final newChatId = await chatRepository.sendMessage(
              event.content,
              event.otherUserId
          );

          // Fetch messages after sending new chat
          final messages = await chatRepository.fetchMessagesForUser(event.otherUserId);

          // Emit sent state with new chat ID
          emit(ChatMessageSent(newChatId, messages));

        } catch (newChatError) {
          print('Failed to create new chat: $newChatError');
          emit(ChatMessageError('Failed to send message and create new chat'));
        }
      }
    });
  }
}
