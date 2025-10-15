import 'package:flutter/material.dart';
import 'package:njm_mobileapp/screens/register_screen.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// NJM Logo
            Image.asset(
              'assets/images/splash_logo.png',
              width: 200,
              height: 200,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// User name or email TextField
                  CustomTextField(label: 'Username, email or mobile number'),

                  SizedBox(height: 15),

                  /// Password TextField
                  CustomTextField(label: 'Password', isPassword: true),

                  SizedBox(height: 15),

                  /// Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button color
                        foregroundColor: Colors.white, // Text color
                        shape: StadiumBorder(),
                      ),
                      child: Text('Log in', style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  /// Forgot password button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => RegisterScreen(),)
                      );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue, width: 1),
                    foregroundColor: Colors.blue, // Text color
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    'Create new account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
