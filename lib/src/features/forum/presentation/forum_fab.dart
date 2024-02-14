import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/navigation_fab.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class ForumFab extends StatelessWidget {
  const ForumFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  NavigationFab(
      location: PageConstants.forum, image: Image.asset('assets/images/forum.png'),

    );
  }
}
