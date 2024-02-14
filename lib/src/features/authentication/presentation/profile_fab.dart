import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/navigation_fab.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class ProfileFab extends StatelessWidget {
  const ProfileFab({
    super.key,
    required this.loggedIn,
  });

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loggedIn,
      child: NavigationFab(
        location: PageConstants.profile,
        image: Image.asset('assets/images/profile.png'),
        onPressed: () {
          context.push('/${PageConstants.profile}');
        }, 
      ),
    );
  }
}
