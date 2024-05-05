import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reffs_parking/car_register_page.dart';
import 'package:reffs_parking/my_cars_page.dart';
import 'package:reffs_parking/my_garage_page.dart';
import 'package:reffs_parking/park_register_page.dart';
import 'package:reffs_parking/reservas_page.dart';


class MapsScreen extends StatefulWidget {
  final double initialLatitud;
  final double initialLongitud;

  MapsScreen({
    required this.initialLatitud,
    required this.initialLongitud,
  });

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Set<Marker> _markers = {}; // Conjunto de marcadores

  @override
  Widget build(BuildContext context) {
    // Añadir el marcador del garaje al conjunto de marcadores
    _markers.add(
      Marker(
        markerId: MarkerId('garage_marker'), // Identificador único del marcador
        position: LatLng(widget.initialLatitud, widget.initialLongitud),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Establecer el color del marcador a rojo
        infoWindow: InfoWindow(title: 'Ubicación del Garaje', snippet: 'Descripción del Garaje'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      drawer: Drawer(
        child: Sidebar(),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLatitud, widget.initialLongitud),
          zoom: 12.0,
        ),
        markers: _markers, // Mostrar los marcadores en el mapa
        onMapCreated: (GoogleMapController controller) {
          // No es necesario asignar el controlador aquí
          // _mapController = controller;
        },
      ),
    );
  }
}


class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 176, 39, 39),
      padding: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterCarPage()),
              );
            },
            child: Column(
              children: [
                Text(
                  'Registrar Auto',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),                 
              ],
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterGaragePage()),
              );
            },
            child: Column(
              children: [
                Text(
                  'Registrar Garage',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyGaragePage()),
              );
            },
            child: Column(
              children: [
                Text(
                  'Mis Garajes',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),                
              ],
            ),
          ),
          SizedBox(height: 20.0),
           GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAutoPage()),
              );
            },
            child: Column(
              children: [
                Text(
                  'Mis Autos',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservasPage()),
              );
            },
            child: Column(
              children: [
                Text(
                  'Reservar Garajes',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Color de texto blanco
                  ),
                ),                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
