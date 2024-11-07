import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extention/spacing.dart';
import '../../cubit/gemini_cubit.dart';
import 'gemini_typing_input_field.dart';

class GeminiActionBar extends StatelessWidget {
  const GeminiActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _ActionButton(
            icon: Icons.mic,
            onPressed: () {},
          ),
          horizontalSpace(15),
          const Expanded(child: GeminiTypingInputField()),
          horizontalSpace(15),
          _ActionButton(
            icon: Icons.arrow_forward_ios_sharp,
            onPressed: () => context.read<GeminiCubit>().sendMessage(),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF8E8E8E)),
        onPressed: onPressed,
      ),
    );
  }
}
