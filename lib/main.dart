import 'package:flutter/material.dart';
import 'package:njm_mobileapp/screens/splash_screen.dart';
import 'package:njm_mobileapp/storage/user_storage.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 71, 30, 50),
  ),
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserStorage.init();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NJM App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const SplashScreen(),
    );
  }
}