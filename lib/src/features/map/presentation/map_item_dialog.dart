import 'package:flutter/material.dart';
import 'package:xs_life/src/features/map/application/maps_utils.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapItemDialog extends StatelessWidget {
  final MapItem mapItem;

  const MapItemDialog({super.key, required this.mapItem});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(mapItem.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Category: ${mapItem.category.title}"),
        ],
      ),
      actions: [
        Row(
          children: [
            const SizedBox(width: 90), // Adjust the width as needed for spacing
            TextButton(
              onPressed: () {
                MapUtils.openMap(context, mapItem.name, mapItem.lat, mapItem.long);
              },
              child: const Text('Navigate'),
            ),
            const SizedBox(width: 10), // Adjust the width as needed for spacing
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      ],
    );
  }
}
