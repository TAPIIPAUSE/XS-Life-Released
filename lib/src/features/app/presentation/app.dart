import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:xs_life/src/features/forum/presentation/forum_state.dart';
import 'package:xs_life/src/routing/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<ForumState>(create: (_) => ForumState()),
      ],
      child: MaterialApp.router(
        title: 'XS Life',
        theme: ThemeData(
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                highlightColor: Colors.orange,
              ),
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        routerConfig: Routes.router,
      ),
    );
  }
}
