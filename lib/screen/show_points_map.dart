import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_of_life/screen/create_quest.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'map/app_lat_long.dart';
import 'map/location_service.dart';

import 'package:uuid/uuid.dart';
/*
class map_page extends StatelessWidget {
  const map_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Соберем эту страницу через центр
    //При этмо оберем ее в column and rows
    return const Center(child: Text("Тут может быть карта",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ));
  }
}
 */
class PointsMapPage extends StatefulWidget {
  const PointsMapPage({Key? key}) : super(key: key);

  @override
  State<PointsMapPage> createState() => _PointsMapPageState();
}

class _PointsMapPageState extends State<PointsMapPage> {
  var set_point = null;
  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> mapObjects = []; //fetch from db
  final MapObjectId mapObjectId = MapObjectId(Uuid().v1());
  //final MapObjectId mapObjectId = MapObjectId('placemark_$counter'); //late?

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотр карты'),
      ),
      body: YandexMap(
          mapObjects: mapObjects,
          onMapCreated: (controller) {
            mapControllerCompleter.complete(controller);
          },
          onMapTap: (Point point) async {
            print('Tapped map at $point');
            //print(mapObjectId);
          }
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                if (mapObjects.any((el) => el.mapId == mapObjectId)) {
                  return;
                }

                final mapObject = ClusterizedPlacemarkCollection(
                  mapId: mapObjectId,
                  radius: 60,
                  minZoom: 15,
                  onClusterAdded: (ClusterizedPlacemarkCollection self, Cluster cluster) async {
                    return cluster.copyWith(
                        appearance: cluster.appearance.copyWith(
                            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                image: BitmapDescriptor.fromAssetImage('assets/info.png'),
                                scale: 1
                            ))
                        )
                    );
                  },
                  onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
                    print('Tapped cluster');
                  },
                  placemarks: [
                    PlacemarkMapObject(
                        mapId: MapObjectId('placemark_1'),
                        point: Point(latitude: 43.15889013914608, longitude: 131.9673829896397),
                        onTap: (PlacemarkMapObject self, Point point) => print('Tapped placemark at $point'),
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage('assets/ok_normal.png'),
                            scale: 1
                        ))
                    ),
                    PlacemarkMapObject(
                        mapId: MapObjectId('placemark_2'),
                        point: Point(latitude: 43.1480614335382, longitude: 131.92679349580732),
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage('assets/ok_normal.png'),
                            scale: 1
                        ))
                    ),
                    PlacemarkMapObject(
                        mapId: MapObjectId('placemark_3'),
                        point: Point(latitude: 43.17078265591427, longitude: 131.9425189040889),
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage('assets/ok_normal.png'),
                            scale: 1
                        ))
                    ),
                  ],
                  onTap: (ClusterizedPlacemarkCollection self, Point point) => print('Tapped me at $point'),
                );

                setState(() {
                  mapObjects.add(mapObject);
                });

              }),
          FloatingActionButton(
              child: Icon(Icons.accessibility),
              onPressed: () {
                _setCamera();
              })
        ],
      ),
    );
  }
  // Future<AppLatLong> _onMapTap: (Point point) async {
  // print('Tapped map at $point');
  //
  // await controller.deselectGeoObject();
  //}
  Future<void> _setCamera() async {

    await _fetchCurrentLocation();
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = VladivostokLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
      AppLatLong appLatLong,
      ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 12,
        ),
      ),
    );
  }

}

