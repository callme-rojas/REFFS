import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reffs_parking/car_register_page.dart';
import 'package:reffs_parking/my_garage_page.dart';
import 'package:reffs_parking/park_register_page.dart';

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
        LatLng(-17.722289, -63.174411); // Ubicación de prueba (Santa Cruz)
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
        backgroundColor: Color.fromARGB(255, 213, 15, 15),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Color.fromARGB(255, 255, 255, 255), // Cambiar a un ícono de menú
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el drawer
              },
            );
          },
        ),
        title: Text(
          'Parkyng System',
          style: TextStyle(color: Colors.white), // Cambia el color del texto a blanco
        ),
      ),
      drawer: Drawer(
        child: Sidebar(),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-17.722289, -63.174411), // Ubicación de prueba (Santa Cruz)
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 176, 39, 39), // Color de fondo
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
                    color: Colors.white, // Color de texto blanco
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
                    color: Colors.white, // Color de texto blanco
                  ),
                ),
                SizedBox(height: 8.0), // SizedBox entre el texto y el botón
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
                    color: Colors.white, // Color de texto blanco
                  ),
                ),                
              ],
            ),
          ),
          SizedBox(height: 20.0),
           GestureDetector(
            /*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterGaragePage()),
              );
            },*/
            child: Column(
              children: [
                Text(
                  'Mis Autos',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Color de texto blanco
                  ),
                ),
                SizedBox(height: 8.0), // SizedBox entre el texto y el botón
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapsScreen(),
  ));
}