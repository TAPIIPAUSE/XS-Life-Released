import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NavigationFab extends StatelessWidget {
  const NavigationFab({
    super.key,
    required this.location,
    required this.image,
    this.onPressed,
  });

  final String location;
  final Image image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(1, 1, 1, 1)),
      child: Visibility(
        visible: !(ModalRoute.of(context)?.settings.name == location),
        child: Container(
          margin: const EdgeInsets.all(10),
          // icon
          child: FloatingActionButton(
            heroTag: location,
            onPressed: onPressed ??
                () {
                  context.replace('/$location');
                },
            backgroundColor: const Color.fromRGBO(255, 175, 54, 1),
            child: image,
          ),
        ),
      ),
    );
  }
}
