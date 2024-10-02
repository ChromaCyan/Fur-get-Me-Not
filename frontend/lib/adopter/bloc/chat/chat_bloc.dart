import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart';
import 'package:fur_get_me_not/adopter/repositories/chat/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<FetchChatMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final messages = await chatRepository.fetchMessages(event.userName);
        emit(ChatMessagesLoaded(messages));
      } catch (e) {
        emit(ChatError('Failed to load messages'));
      }
    });

    on<SendMessage>((event, emit) {
      try {
        chatRepository.sendMessage(event.userName, event.message);
        // Refresh messages after sending
        add(FetchChatMessages(event.userName));
      } catch (e) {
        emit(ChatError('Failed to send message'));
      }
    });
  }
}

