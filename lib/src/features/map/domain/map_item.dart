import 'package:xs_life/src/features/map/domain/map_category.dart';

class MapItem {
  final String id;
  final double lat;
  final double long;
  final String name;
  final MapCategory category;

  MapItem(this.id, this.lat, this.long, this.name, this.category);
}
