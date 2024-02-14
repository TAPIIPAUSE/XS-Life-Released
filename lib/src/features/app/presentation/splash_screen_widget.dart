import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenWidgetState();
}

class SplashScreenWidgetState extends State<SplashScreenWidget> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // For testing, set the firstTime to false, like "bool? firstTime = false"
    bool? firstTime = prefs.getBool('first_time');
    // bool? firstTime = false;

    const duration = Duration(seconds: 1);

    if (firstTime == null || !firstTime) {
      prefs.setBool('first_time', true);
      return Timer(duration, navigationToIntroduction);
    } else {
      return Timer(duration, navigationToMap);
    }
  }

  void navigationToMap() {
    context.replace("/${PageConstants.map}");
  }

  void navigationToIntroduction() {
    context.replace("/${PageConstants.introduction}");
  }

  @override
  Widget build(BuildContext context) {
    startTime();
    return LoadingScreenWidget();
  }
}
