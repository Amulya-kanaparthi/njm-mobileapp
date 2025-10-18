import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
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
              ImageConstants.splashLogo,
              width: 200,
              height: 200,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// User name or email TextField
                  CustomTextField(label: StringConstants.userNameEmailMobileNumber),

                  SizedBox(height: 15),

                  /// Password TextField
                  CustomTextField(label: StringConstants.password, isPassword: true),

                  SizedBox(height: 15),

                  /// Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary, // Button color
                        foregroundColor: Colors.white, // Text color
                        shape: StadiumBorder(),
                      ),
                      child: Text(ButtonStrConstants.login, style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  /// Forgot password button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          ButtonStrConstants.forgotPassword,
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
                    side: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                    foregroundColor: Theme.of(context).colorScheme.secondary, // Text color
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    ButtonStrConstants.createNewAccount,
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
