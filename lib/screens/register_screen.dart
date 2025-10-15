import 'package:flutter/material.dart';
import 'package:njm_mobileapp/screens/login_screen.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Screen')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Username TextField
                  CustomTextField(label: 'Username'),
                  SizedBox(height: 15),

                  /// Phone number TextField
                  CustomTextField(label: 'Phone number'),
                  SizedBox(height: 15),

                  /// Email TextField
                  CustomTextField(label: 'Email'),
                  SizedBox(height: 15),

                  /// Password TextField
                  CustomTextField(label: 'Password', isPassword: true),
                  SizedBox(height: 15),

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
                      child: Text('Create', style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  Text('or'),
                  SizedBox(height: 15),

                  /// Signup with google
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle Google Sign-Up logic here
                      },
                      icon: Image.asset(
                        'assets/images/google_logo.png',
                        height: 24, // Icon size
                        width: 24,
                      ),
                      label: Text(
                        'Sign up with Google',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue, width: 1),
                        shape: StadiumBorder(),
                        foregroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Already have an account?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the alert
                          },
                          child: Text(
                            'Continue creating account'.toUpperCase(),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 131, 35, 28),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text('Log in'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'I already have an account',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
