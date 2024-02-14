import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/features/map/data/map_repository_interface.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapRepository extends IMapRepository {
  CollectionReference<Map<String, dynamic>> mapCollection =
      FirebaseFirestore.instance.collection(CollectionConstants.map);

  CollectionReference<Map<String, dynamic>> mapCategoryCollection =
      FirebaseFirestore.instance.collection(CollectionConstants.mapCategory);

  @override
  Future<List<MapCategory>> getCategories() async {
    List<MapCategory> categories = [];
    var mapCategoryDoc = await mapCategoryCollection.get();

    if (mapCategoryDoc.size > 0) {
      for (var i = 0; i < mapCategoryDoc.size; i++) {
        categories.add(
          MapCategory(
            mapCategoryDoc.docs[i].id,
            mapCategoryDoc.docs[i].data()['title'],
          ),
        );
      }
    }
    return categories;
  }

  @override
  Future<MapCategory> getCategory(String id) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<MapItem> getMapItem(String id) {
    // TODO: implement getMapItem
    throw UnimplementedError();
  }

  @override
  Future<List<MapItem>> getMapItems(List<MapCategory> categories) async {
    List<MapItem> mapItems = [];
    var mapDoc = await mapCollection.get();

    if (mapDoc.size > 0) {
      for (var i = 0; i < mapDoc.size; i++) {
        MapCategory mapCategory = categories.firstWhere((element) =>
            element.id ==
            mapDoc.docs[i].data()['points_of_interests_category_key']);

        mapItems.add(
          MapItem(
            mapDoc.docs[i].id,
            mapDoc.docs[i].data()['lat'] as double,
            mapDoc.docs[i].data()['long'] as double,
            mapDoc.docs[i].data()['name'],
            mapCategory,
          ),
        );
      }
    }
    return mapItems;
  }
}
