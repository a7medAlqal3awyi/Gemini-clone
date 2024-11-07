import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini/home/cubit/gemini_cubit.dart';

import '../../core/extention/spacing.dart';
import '../../onboarding/widgets/gradient_text.dart';
import '../model/response_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GeminiAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GeminiCubit, GeminiState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildMainContent(context, state),
                    );
                  },
                ),
              ),
              const GeminiActionBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, GeminiState state) {
    if (state is GeminiSendMessage) {
      return MessageListView(messages: state.messages);
    }
    return const InitialPromptView();
  }
}

class GeminiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeminiAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.menu, size: 25),
      ),
      title: GradientText(
        "Gemini",
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/a/ACg8ocJ1PlzCTxA_rxHKJCoRKGBuF5KndmJJLxK37VuvPVAKQjYzNpF7=s317-c-no",
            ),
          ),
        ),
      ],
    );
  }
}

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

  const _ActionButton({required this.icon, required this.onPressed, super.key});

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

class InitialPromptView extends StatefulWidget {
  const InitialPromptView({super.key});

  @override
  _InitialPromptViewState createState() => _InitialPromptViewState();
}

class _InitialPromptViewState extends State<InitialPromptView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();

    _fadeAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientText(
          "Hello, Ahmed",
          style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        SlideTransition(
          position: _fadeAnimation,
          child: Text(
            'What can I help with?',
            style: TextStyle(height: 1.7, color: Colors.black, fontSize: 30.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

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
