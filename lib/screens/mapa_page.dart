import 'dart:async';

import 'package:app_fireman/screens/product_screen.dart';
import 'package:app_fireman/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'confirmation_screen.dart';

class MapaPage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación de Emergencia'),
        shadowColor: Colors.deepPurple,
         backgroundColor: const Color.fromARGB(255, 194, 37, 45),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: ()  {
              final route = MaterialPageRoute(
                                builder: (context) => ProductScreen());
                            Navigator.push(context, route);

              // final route = MaterialPageRoute(
              //                   builder: (context) => ConfirmationScreen());
              //               Navigator.push(context, route);

            },
          )
        ],
      ),
      body: MapSample(),
    );
    // return MaterialApp(
    //   title: 'Flutter Google Maps Demo',
    //   home: MapSample(),
    // );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
   Set<Marker> _markers={};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.473929, -90.521778),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(14.473929, -90.521778),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  void initState(){
    super.initState();
    setState(() {
      _goToTheLake();
    });
  }
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Mi ubicación!'),
        icon: const Icon(Icons.near_me),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    final mapService = Provider.of<MapServices>(context, listen: false);
    Location currentLocation = Location();
   
    var location = await currentLocation.getLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    currentLocation.onLocationChanged.listen((LocationData loc) {
      controller
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));

      mapService.setCoordenates(loc.latitude.toString(), loc.longitude.toString());
      print(loc.latitude);
      print(loc.longitude);
       setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
    });
  }
}
