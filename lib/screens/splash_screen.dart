import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/network/bible_service.dart';
import 'package:njm_mobileapp/screens/login_screen.dart';
import 'package:njm_mobileapp/screens/tabs.dart';
import 'package:njm_mobileapp/storage/user_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  bool _isloggedIn = false;

  @override
  void initState() {
    super.initState();
    _initApp();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _opacity = 1.0);
    });
  }

  /// ✅ Combined initialization (Login check + Bible preload)
  Future<void> _initApp() async {
    // Check if user is logged in
    final loggedIn = await UserStorage.isLoggedIn();

    // Preload Bible (only once)
    try {
      await BibleService.fetchBibleFromAPI('english');
      // Optionally load Telugu too:
      // await BibleService.fetchBibleFromAPI('telugu');
    } catch (e) {
      print("⚠️ Bible preload failed: $e");
    }

    setState(() {
      _isloggedIn = loggedIn;
    });

    // Wait for 3–5 seconds total splash duration
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              _isloggedIn ? const TabsScreen() : const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ImageConstants.splashLogo, width: 150),
              const SizedBox(height: 20),
              const Text(
                'Hey Welcome!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
