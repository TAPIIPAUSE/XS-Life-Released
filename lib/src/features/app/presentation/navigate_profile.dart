import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xs_life/src/common_widgets/navigation_fab.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:xs_life/src/features/authentication/presentation/authentication_fab.dart';
import 'package:xs_life/src/features/authentication/presentation/profile_fab.dart';
import 'package:xs_life/src/features/forum/presentation/forum_fab.dart';

class FabNavigateprofile extends StatelessWidget {
  const FabNavigateprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Wrap(
        direction: Axis.vertical,
        children: [
          AuthenticationFab(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              }),
          ProfileFab(loggedIn: appState.loggedIn),
        ],
      ),
    );
  }
}
