import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemini/home/cubit/gemini_cubit.dart';
import 'package:gemini/home/screen/widgets/gemini_action_bar.dart';
import 'package:gemini/home/screen/widgets/gemini_app_bar.dart';
import 'package:gemini/home/screen/widgets/initial_prompt_view.dart';
import 'package:gemini/home/screen/widgets/message_list_view.dart';

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
