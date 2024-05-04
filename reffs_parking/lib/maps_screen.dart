import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    // Obtener la ubicación actual del usuario
    // Puedes utilizar el paquete geolocator o algún otro método
    // y establecer la cámara del mapa en esa ubicación
    LatLng currentLocation =
        LatLng(37.7749, -122.4194); // Ubicación de prueba (San Francisco)
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 12.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Google'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(37.7749, -122.4194), // Ubicación de prueba (San Francisco)
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
