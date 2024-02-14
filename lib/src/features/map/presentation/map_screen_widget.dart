import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/constants/app_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';
import 'package:latlong2/latlong.dart';
import 'package:xs_life/src/features/map/presentation/map_filter_dialog.dart';
import 'package:xs_life/src/features/map/presentation/map_item_dialog.dart';

class MapScreenWidget extends StatefulWidget {
  const MapScreenWidget(
      {super.key,
      required this.mapItems,
      required this.mapCategories,
      required this.isLoading});

  @override
  State<StatefulWidget> createState() => MapScreenWidgetState();

  final List<MapItem> mapItems;
  final List<MapCategory> mapCategories;
  final bool isLoading;
}

class MapScreenWidgetState extends State<MapScreenWidget> {
  getMarker(MapItem mapItem) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MapItemDialog(mapItem: mapItem);
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/1946/1946770.png',
          height: 30,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<MapCategory> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];

    if (widget.mapItems.isNotEmpty) {
      for (MapItem element in widget.mapItems) {
        if (selectedCategories.isEmpty ||
            selectedCategories.contains(element.category)) {
          marker.add(Marker(
            point: LatLng(element.lat, element.long),
            builder: (context) {
              return getMarker(element);
            },
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
        ],
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 255, 110, 14),
                Color.fromARGB(255, 252, 213, 134)
              ])),
        ),
      ),
      body: widget.isLoading
          ? const LoadingScreenWidget()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 243, 243),
                  borderRadius: BorderRadius.circular(17),
                ),
                margin: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: FlutterMap(
                          options: MapOptions(
                            center: AppConstants.kmuttLocation,
                            zoom: AppConstants.mapZoom,
                            interactiveFlags:
                                InteractiveFlag.all - InteractiveFlag.rotate,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            ),
                            CurrentLocationLayer(),
                            MarkerLayer(
                              markers: marker,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () async {
                          // setState(() async {
                          //   selectedCategories =
                          // });
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MapFilterDialog(
                                  mapCategories: widget.mapCategories,
                                  selected: selectedCategories);
                            },
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.find_in_page),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 255, 110, 14),
                                    Color.fromARGB(255, 252, 213, 134)
                                  ])),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  'KMUTT MAP',
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
