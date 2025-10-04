import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ymm/pages/navpage.dart';
import 'package:ymm/models/state.dart';


// https://docs.flutter.dev/ui/widgets/material

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: YMM(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: appState.seedColor,
            brightness: Brightness.dark
          ),
          fontFamily: "dubai",
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: "dubai",
              decoration: TextDecoration.none,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontFamily: "dubai",
              decoration: TextDecoration.none,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              fontFamily: "dubai",
              decoration: TextDecoration.none,
              fontSize: 18,
            ),
            bodyMedium: TextStyle(
              fontFamily: "dubai",
              decoration: TextDecoration.none,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}