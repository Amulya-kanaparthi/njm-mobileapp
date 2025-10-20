import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/screens/tabs.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _enteredOtp = '';
  bool _isLoading = false;

  void _submitOTP() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiHandler.postRequest(
        EndPoint.verifyOTP,
        body: {KeyConstants.email: widget.email, KeyConstants.otp: _enteredOtp},
      );

      if (response['status'] == 1) {
        //Registration successful, navigate to login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TabsScreen()),
        );
      } else {
        //Handle registration error
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'Failed',
          message:
              response['message'] ??
              'An error occurred during otp verification.',
        );
      }
    } catch (error) {
      // Handle API errors
      AlertDialogHelper.showBasicAlert(
        context: context,
        title: 'Error',
        message: error.toString(),
      );
    } finally {
      setState(() => _isLoading = false); // Hide loader
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.otpScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringConstants.enterOTPSentToRegisteredEmail,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) => _enteredOtp = value,
              onCompleted: (value) => _enteredOtp = value,
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(
                context,
              ).colorScheme.onSecondaryFixedVariant,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                borderWidth: 0.5,
                fieldHeight: 50,
                fieldWidth: 45,
                activeColor: Theme.of(context).colorScheme.secondary,
                selectedColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(
                  context,
                ).colorScheme.onSecondaryFixedVariant,
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitOTP,
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
