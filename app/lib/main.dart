import 'package:app/resources/constants.dart';
import 'package:app/resources/home_state.dart';
import 'package:app/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:provider/provider.dart';

final homeState = StateProvider(
  (ref) => HomeState(
      isDarkMode:
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark),
);

void main() async {
  runApp(ProviderScope(
    child: MultiProvider(
      providers: [
        Provider<HomeState>(
          create: (_) => HomeState(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Detect if dark mode is enabled
    final isDarkMode = ref.watch(homeState).isDarkMode;
    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
