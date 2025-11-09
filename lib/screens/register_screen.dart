import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/screens/login_screen.dart';
import 'package:njm_mobileapp/screens/otp_screen.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
import 'package:njm_mobileapp/utility/utility.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredUsername = '';
  var _enteredPhonenum = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

  void _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true); // Show loader

    try {
      final response = await ApiHandler.postRequest(
        EndPoint.register,
        body: {
          KeyConstants.username: _enteredUsername,
          KeyConstants.phoneNumber: _enteredPhonenum,
          KeyConstants.email: _enteredEmail,
          KeyConstants.password: _enteredPassword,
        },
      );

      if (response['status'] == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(email: _enteredEmail),
          ),
        );
      } else {
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'Registration Failed',
          message:
              response['message'] ?? 'An error occurred during registration.',
        );
      }
    } catch (e) {
      // Handle API errors
      AlertDialogHelper.showBasicAlert(
        context: context,
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      setState(() => _isLoading = false); // Hide loader
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.registerScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// Username TextField
                      CustomTextField(
                        label: StringConstants.userName,
                        validator: Utility.username,
                        onsaved: (value) {
                          _enteredUsername = value!;
                        },
                      ),
                      SizedBox(height: 15),

                      /// Phone number TextField
                      CustomTextField(
                        label: StringConstants.phoneNumber,
                        validator: Utility.phone,
                        onsaved: (newValue) {
                          _enteredPhonenum = newValue!;
                        },
                      ),
                      SizedBox(height: 15),

                      /// Email TextField
                      CustomTextField(
                        label: StringConstants.email,
                        validator: Utility.email,
                        onsaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                      SizedBox(height: 15),

                      /// Password TextField
                      CustomTextField(
                        label: StringConstants.password,
                        isPassword: true,
                        validator: Utility.password,
                        onsaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                      SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: _submitRegistration,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary, // Button color
                                  foregroundColor: Colors.white, // Text color
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  ButtonStrConstants.create,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                      SizedBox(height: 25),
                      // Text('or', style: TextStyle(fontSize: 16)),
                      // SizedBox(height: 10),

                      /// Signup with google
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 50,
                      //   child: OutlinedButton.icon(
                      //     onPressed: () async {
                      //       // Handle Google Sign-Up logic here
                      //       // final user = await AuthService().signInWithGoogle();
                      //       // if (user != null) {
                      //       //   print('User signed up with Google: $user');
                      //       // } else {
                      //       //   print('Google Sign-Up failed or was cancelled');
                      //       // }
                      //     },
                      //     icon: Image.asset(
                      //       ImageConstants.googleLogo,
                      //       height: 24, // Icon size
                      //       width: 24,
                      //     ),
                      //     label: Text(
                      //       StringConstants.googleSignIn,
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: Theme.of(context).colorScheme.primary,
                      //       ),
                      //     ),
                      //     style: OutlinedButton.styleFrom(
                      //       side: BorderSide(
                      //         color: Theme.of(context).colorScheme.primary,
                      //         width: 1,
                      //       ),
                      //       shape: StadiumBorder(),
                      //       foregroundColor: Theme.of(
                      //         context,
                      //       ).colorScheme.primary,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
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
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}
