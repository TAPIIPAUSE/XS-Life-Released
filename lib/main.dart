import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:xs_life/src/constants/firebase_options.dart';
import 'package:xs_life/src/features/app/presentation/app.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      builder: ((context, child) => const App()),
    ),
  );
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}
