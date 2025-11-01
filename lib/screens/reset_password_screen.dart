import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/utility/Utility.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
import 'package:njm_mobileapp/widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredNewPassword = '';

  bool _isLoading = false;

  void _submitResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true); // Show loader

    try {
      final response = await ApiHandler.postRequest(
        EndPoint.resetPassword,
        body: {
          KeyConstants.email: widget.email,
          KeyConstants.password: _enteredNewPassword,
        },
      );

      if (response['status'] == 1) {
        AlertDialogHelper.showActionAlert(
          context: context,
          title: "Successfull",
          message: "Reset password succesful",
          actions: [DialogType.ok],
          onActionPressed: (action) {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      } else {
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'Reset password Failed',
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
      appBar: AppBar(title: const Text(StringConstants.resetPasswordScreenTitle)),
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
                      /// Email TextField
                      CustomTextField(
                        label: StringConstants.newPassword,
                        isPassword: true,
                        validator: Utility.password,
                        onsaved: (newValue) {
                          _enteredNewPassword = newValue!;
                        },
                      ),
                      SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: _submitResetPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary, // Button color
                                  foregroundColor: Colors.white, // Text color
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  ButtonStrConstants.reset,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                      SizedBox(height: 10),
                    ],
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
