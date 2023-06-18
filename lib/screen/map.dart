import 'dart:async';

import 'package:flutter/material.dart';
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
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> mapObjects = [];
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
        title: const Text('Добавьте точку'),
      ),
      body: YandexMap(
          mapObjects: mapObjects,
          onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
          onMapTap: (Point point) async {
            print('Tapped map at $point');
            //print(mapObjectId);
            final mapObject = PlacemarkMapObject(
                mapId: mapObjectId,
                point: point,
                onTap: (PlacemarkMapObject self, Point point) => print('Tapped me at $point'),
                isDraggable: true,
                onDragStart: (_) => print('Drag start'),
                onDrag: (_, Point point) => print('Drag at point $point'),
                onDragEnd: (_) => print('Drag end'),
                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/place.png')
                ))
            );
            setState(() {
              mapObjects.add(mapObject);
            });
            //print(mapObjects);
          }
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _addMark)
        ],
      ),
    );
  }
  // Future<AppLatLong> _onMapTap: (Point point) async {
  // print('Tapped map at $point');
  //
  // await controller.deselectGeoObject();
  //}
  Future<void> _addMark() async {

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

