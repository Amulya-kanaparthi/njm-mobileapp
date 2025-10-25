import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/models/user_model.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/screens/forgot_password_screen.dart';
import 'package:njm_mobileapp/screens/register_screen.dart';
import 'package:njm_mobileapp/screens/tabs.dart';
import 'package:njm_mobileapp/storage/secure_storage.dart';
import 'package:njm_mobileapp/storage/user_storage.dart';
import 'package:njm_mobileapp/utility/Utility.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _isLoading = false;

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      final response = await ApiHandler.postRequest(
        EndPoint.login,
        body: {
          KeyConstants.email: _enteredEmail,
          KeyConstants.password: _enteredPassword,
        },
      );

      if (response[KeyConstants.status] == 1) {
        final accessToken = response[KeyConstants.access_token];
        final refreshToken = response[KeyConstants.refresh_token];

        final userJson = response[KeyConstants.user];
        final user = UserModel.fromJson(userJson);

        await SecureStorage.saveData(KeyConstants.access_token, accessToken);
        await SecureStorage.saveData(KeyConstants.refresh_token, refreshToken);

        await UserStorage.saveUser(user);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      } else {
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'Login Failed',
          message: response['message'] ?? 'Please try again later.',
        );
      }
    } catch (e) {
      AlertDialogHelper.showBasicAlert(
        context: context,
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      ImageConstants.splashLogo,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email TextField
                          CustomTextField(
                            label: StringConstants.userNameEmailMobileNumber,
                            validator: Utility.email,
                            onsaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Password TextField
                          CustomTextField(
                            label: StringConstants.password,
                            isPassword: true,
                            validator: Utility.password,
                            onsaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom "Already have account?" section
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
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
                child: const Text(
                  'I already have an account',
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
