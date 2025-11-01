import 'dart:async';

import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/screens/reset_password_screen.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  var _enteredEmail = '';
  bool _isLoading = false;
  Timer? _pollTimer;

  void _submitEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    _enteredEmail = email;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiHandler.postRequest(
        EndPoint.forgotPassword,
        body: {KeyConstants.email: _enteredEmail},
      );

      if (response[KeyConstants.status] == 1) {
        startPolling(_enteredEmail);
      } else {
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'Error',
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
      // setState(() => _isLoading = false);
    }
  }

  void startPolling(String email) {
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _checkForAuthentication(email);
    });
  }

  Future _checkForAuthentication(String email) async {
    try {
      final response = await ApiHandler.postRequest(
        EndPoint.checkAuthentication,
        body: {KeyConstants.email: _enteredEmail},
      );

      if (response[KeyConstants.status] == 1) {
        _pollTimer?.cancel();
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email)),
        );
      }
    } catch (e) {
      AlertDialogHelper.showBasicAlert(
        context: context,
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      // setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringConstants.forgotPasswordScreenTitle)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringConstants.enterRegisteredEmail,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            CustomTextField(
              label: StringConstants.email,
              controller: _emailController,
            ),
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary, // Button color
                        foregroundColor: Colors.white, // Text color
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        ButtonStrConstants.submit,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
