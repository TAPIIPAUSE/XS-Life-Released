import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("XS Life"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(GlobalConfiguration().get('lat').toString()),
            ],
          ),
        ),
        floatingActionButton: const FabNavigationWidget(),
    );
  }
}
