import 'package:book_wallert/screens/main_screen/main_screen_frame.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/user_api_service.dart';

class UserController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserApiService userApiService = UserApiService();

  Future<void> editUserDetails(BuildContext context) async {
    try {
      await userApiService.editUserDetails(usernameController.text,
          emailController.text, passwordController.text);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update'),
          ),
        );
      }
    }
  }
}
