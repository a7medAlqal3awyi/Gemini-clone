import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/gemini_cubit.dart';

class GeminiTypingInputField extends StatefulWidget {
  const GeminiTypingInputField({super.key});

  @override
  _GeminiTypingInputFieldState createState() => _GeminiTypingInputFieldState();
}

class _GeminiTypingInputFieldState extends State<GeminiTypingInputField> {
  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<GeminiCubit>().formKey,
      child: TextFormField(
        controller: context.read<GeminiCubit>().textEditingController,
        onChanged: (value) {
          if (context.read<GeminiCubit>().messagesList.isEmpty) {
            setState(() {
              isTyping = value.isNotEmpty;
            });
            context.read<GeminiCubit>().changeTypingState(value.isNotEmpty);
          }
        },
        maxLines: null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Ask Gemini',
          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
