import 'package:bloc/bloc.dart';
import 'package:fur_get_me_not/adoptee/repositories/chat/admin_chat_list_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';

class AdminChatBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final AdminChatRepository adminChatRepository;

  AdminChatBloc(this.adminChatRepository) : super(ChatMessageInitial()) {
    // Handle FetchMessages event
    on<FetchMessages>((event, emit) async {
      emit(ChatMessageLoading());
      try {
        final messages =
            await adminChatRepository.fetchMessagesForUser(event.otherUserId);
        emit(ChatMessageLoaded(messages));
      } catch (e) {
        emit(ChatMessageError('Failed to load messages: $e'));
      }
    });

    // Handle SendMessage event
    on<SendMessage>((event, emit) async {
      emit(ChatMessageLoading());
      try {
        await adminChatRepository.sendMessage(event.content, event.otherUserId);
        final messages =
            await adminChatRepository.fetchMessagesForUser(event.otherUserId);
        emit(ChatMessageLoaded(messages));
      } catch (e) {
        emit(ChatMessageError('Failed to send message: $e'));
      }
    });
  }
}
