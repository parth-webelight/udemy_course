import 'chat_message_model.dart';

class ChatStateModel {
  final List<ChatMessageModel> messages;
  final bool isLoading;
  final bool isSending;
  final String currentMessage;

  const ChatStateModel({
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.currentMessage = '',
  });

  ChatStateModel copyWith({
    List<ChatMessageModel>? messages,
    bool? isLoading,
    bool? isSending,
    String? currentMessage,
  }) {
    return ChatStateModel(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      currentMessage: currentMessage ?? this.currentMessage,
    );
  }
}