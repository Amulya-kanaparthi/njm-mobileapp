import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/image_constants.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/models/user_model.dart';
import 'package:njm_mobileapp/network/api_handler.dart';
import 'package:njm_mobileapp/network/end_point.dart';
import 'package:njm_mobileapp/screens/login_screen.dart';
import 'package:njm_mobileapp/storage/secure_storage.dart';
import 'package:njm_mobileapp/storage/user_storage.dart';
import 'package:njm_mobileapp/utility/showAlertDialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final user = await UserStorage.getUser();

    if (user == null) {
      // Handle missing user
      print("No user found. Redirecting to login...");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }

    setState(() {
      _user = user;
    });
  }

  void _logOut() async {
    try {
      final accessToken =
          await SecureStorage.getString(KeyConstants.access_token) ?? '';

      final response = await ApiHandler.postRequest(
        EndPoint.logout,
        headers: {KeyConstants.access_token: accessToken},
      );

      if (response[KeyConstants.status] == 1) {
        await SecureStorage.clearAll();
        await UserStorage.clearUser();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        AlertDialogHelper.showBasicAlert(
          context: context,
          title: 'logout Failed',
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
    if (_user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Profile Picture
            CircleAvatar(
              radius: 60,
              foregroundImage: AssetImage(ImageConstants.profileIcon),
            ),
            const SizedBox(height: 16),
            // Name and Email
            Text(
              _user!.username,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(_user!.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Options List
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  cardWidget(Icons.settings, 'Account Settings'),
                  cardWidget(Icons.lock, 'Privacy'),
                  cardWidget(Icons.notifications, 'Notifications'),
                  cardWidget(Icons.help_outline, 'Help & Support'),
                  cardWidget(Icons.logout, 'Logout', color: Colors.red,onTap: _logOut),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardWidget(IconData icon, String title, {Color color = Colors.black,VoidCallback? onTap}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color, fontSize: 16)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color.fromARGB(255, 34, 33, 33),
        ),
        onTap: onTap,
      ),
    );
  }
}
