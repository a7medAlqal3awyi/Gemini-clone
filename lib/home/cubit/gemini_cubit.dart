import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/networking/api_constants.dart';
import '../../core/networking/api_gemini_sevices.dart';
import '../model/response_model.dart';

part 'gemini_state.dart';

class GeminiCubit extends Cubit<GeminiState> {

  bool isTyping = false;
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<ResponseModel> messagesList = [];
  ScrollController scrollController = ScrollController();

  GeminiAPIService service = GeminiAPIService(apiKey: ApiConstants.apiKey);
  GeminiCubit() : super(GeminiInitial());


  void changeTypingState(bool value) {
    isTyping = value;
    emit(GeminiTypingState(isTyping));
  }

  void clearText() {
    textEditingController.clear();
    changeTypingState(false);
  }

  void clearMessages() {
    messagesList = [];
    emit(GeminiInitial());
  }

  Future<void> sendMessage() async {
    if (formKey.currentState!.validate()) {
      emit(GeminiSendingMessage());

      final userMessage = ResponseModel(
        message: textEditingController.text,
        sender: "user",
        time: DateTime.now().toString(),
      );
      messages.add(userMessage);
      scrollToBottom();
      final userInput = textEditingController.text;
      textEditingController.clear();

      final botLoadingMessage = ResponseModel(
        message: "Gemini typing. . .",
        sender: "bot",
        time: DateTime.now().toString(),
      );
      messages.add(botLoadingMessage);
      emit(GeminiSendMessage(List.from(messages)));
      scrollToBottom();

      try {
        final botResponse = await service.generateContent(userInput);

        messages.remove(botLoadingMessage);

        final botMessage = ResponseModel(
          message: botResponse ?? "I'm sorry, I couldn't understand that. Please try rephrasing your question or providing more context.",
          sender: "bot",
          time: DateTime.now().toString(),
        );
        messages.add(botMessage);
        messagesList = messages;
        scrollToBottom();
        await Future.delayed(const Duration(seconds: 1));

        emit(GeminiSendMessage(List.from(messages)));
      } catch (e) {
        messages.remove(botLoadingMessage);
        final errorMessage = ResponseModel(
          message: "Something went wrong. Please try again.",
          sender: "bot",
          time: DateTime.now().toString(),
        );
        messages.add(errorMessage);
        messagesList = messages;
        scrollToBottom();
        emit(GeminiSendMessage(List.from(messages)));
      }
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


}
