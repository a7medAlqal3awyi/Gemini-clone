import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/gemini_cubit.dart';
import '../../model/response_model.dart';

class MessageListView extends StatelessWidget {
  final List<ResponseModel> messages;

  const MessageListView({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      controller: context.read<GeminiCubit>().scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUserMessage = message.sender == "user";

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Align(
            alignment:
            isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 0.75.sw),
              child: Container(
                decoration: BoxDecoration(
                  color: isUserMessage
                      ? const Color.fromRGBO(112, 129, 230, 1).withOpacity(.2)
                      : const Color(0xFF3D3D3D).withOpacity(.1),
                  borderRadius: BorderRadius.all(Radius.circular(14.r)),
                ),
                padding: EdgeInsets.all(10.h),
                child: MarkdownBody(
                  data: message.message, // Render Markdown-formatted text
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
