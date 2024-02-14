import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';

class AuthService {
  static bool loggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static String getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<bool> authCheck(BuildContext context) async {
    if (!loggedIn()) {
      _dialog(
          context,
          'User is not logged in',
          'Do you want to login?', () {
        Navigator.of(context).pop();
        context.push("/${PageConstants.signIn}");
      });
      return false;
    }

    UserRepository userRepository = UserRepository();

    if (await userRepository.getUserDetails(getUid()) == null) {
      _dialog(
          context,
          'Please provide user details before performing this action',
          'Do you want to edit your user details?', () {
        Navigator.of(context).pop();
        context.push("/${PageConstants.profile}");
      });
      return false;
    }

    return true;
  }

  static dynamic _dialog(BuildContext context, title, text, action) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: [
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: action,
                ),
              ],
            ));
  }
}
