import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/home/cubit/gemini_cubit.dart';

import 'gemini.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
      create: (context) => GeminiCubit(), child: const GeminiApp()));
}
