import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/screens/login_screen.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
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
      appBar: AppBar(title: const Text(StringConstants.registerScreenTitle)),
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
                  CustomTextField(label: StringConstants.userName),
                  SizedBox(height: 15),

                  /// Phone number TextField
                  CustomTextField(label: StringConstants.phoneNumber),
                  SizedBox(height: 15),

                  /// Email TextField
                  CustomTextField(label: StringConstants.email),
                  SizedBox(height: 15),

                  /// Password TextField
                  CustomTextField(label: StringConstants.password, isPassword: true),
                  SizedBox(height: 15),

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
                      child: Text(ButtonStrConstants.create, style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  Text('or'),
                  SizedBox(height: 15),

                  /// Signup with google
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () async{
                        // Handle Google Sign-Up logic here
                        final user = await AuthService().signInWithGoogle();
                        if(user != null){ 
                          print('User signed up with Google: $user');   
                        }else{
                          print('Google Sign-Up failed or was cancelled');
                        }
                      },
                      icon: Image.asset(
                        ImageConstants.googleLogo,
                        height: 24, // Icon size
                        width: 24,
                      ),
                      label: Text(
                        StringConstants.googleSignIn,
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
                        shape: StadiumBorder(),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                AlertDialogHelper.showActionAlert(
                  context: context,
                  title: "",
                  message: StringConstants.alreadyHaveAccount,
                  actions: [
                    DialogType.continueCreatingAccount,
                    DialogType.login,
                  ],
                  onActionPressed: (action) {
                    if (action == DialogType.continueCreatingAccount) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                );
              },
              child: Text(
                StringConstants.iAlreadyHaveAccount,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
