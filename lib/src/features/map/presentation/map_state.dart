import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/map/data/map_repository.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapState extends ChangeNotifier {
  MapState() {
    init();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  StreamSubscription<QuerySnapshot>? _mapItemsSubscription;
  List<MapItem> _mapItems = [];

  List<MapItem> get mapItems => _mapItems;

  List<MapCategory> _mapCategories = [];

  List<MapCategory> get mapCategories => _mapCategories;

  MapRepository mapRepository = MapRepository();

  Future<void> init() async {
    _mapCategories = await mapRepository.getCategories();
    _mapItems = await mapRepository.getMapItems(_mapCategories);
    _isLoading = false;
    notifyListeners();
  }
}
