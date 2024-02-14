import 'package:flutter/material.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';

class MapFilterDialog extends StatefulWidget {
  const MapFilterDialog({
    super.key,
    required this.mapCategories,
    required this.selected,
  });

  final List<MapCategory> mapCategories;
  final List<MapCategory> selected;

  @override
  State<MapFilterDialog> createState() => _MapFilterDialogState();
}

class _MapFilterDialogState extends State<MapFilterDialog> {
  @override
  Widget build(BuildContext context) {
    if (widget.selected.isEmpty) {
      for (var element in widget.mapCategories) {
        widget.selected.add(element);
      }
    }

    var listview = ListView.builder(
      shrinkWrap: true,
      itemCount: widget.mapCategories.length,
      itemBuilder: (_, index) {
        return CheckboxListTile(
          title: Text(widget.mapCategories[index].title),
          value: widget.selected.contains(widget.mapCategories[index]),
          onChanged: (val) {
            var element = widget.mapCategories[index];
            if (widget.selected.contains(element)) {
              widget.selected.remove(element);
            } else {
              widget.selected.add(element);
            }
            setState(() {});
          },
        );
      },
    );

    return AlertDialog(
      title: const Text("Filter"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: listview,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
