part of 'gemini_cubit.dart';

@immutable
sealed class GeminiState {}

final class GeminiInitial extends GeminiState {}

final class GeminiTypingState extends GeminiState {
  final bool isTyping;

  GeminiTypingState(this.isTyping);
}

final class GeminiSendingMessage extends GeminiState {}

final class GeminiSendMessage extends GeminiState {
  final List<ResponseModel> messages;

  GeminiSendMessage(this.messages);
}