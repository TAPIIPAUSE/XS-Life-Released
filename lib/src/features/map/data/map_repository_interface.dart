import 'package:xs_life/src/common_widgets/repository_interface.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

abstract class IMapRepository extends IRepository {
  Future<List<MapCategory>> getCategories();
  Future<MapCategory> getCategory(String id);
  Future<List<MapItem>> getMapItems(List<MapCategory> categories);
  Future<MapItem> getMapItem(String id);
}
