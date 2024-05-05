import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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
  Set<Marker> _markers = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadGarajes();
  }

  Future<void> _loadGarajes() async {
    try {
      final response = await http.get(Uri.parse('https://parkingsystem-hjcb.onrender.com/garajes/getGarajesDisponibles'));

      if (response.statusCode == 200) {
        List<dynamic> garajesData = json.decode(response.body);

        for (var garajeData in garajesData) {
          double lat = double.parse(garajeData['lat']);
          double lng = double.parse(garajeData['lng']);

          _markers.add(
            Marker(
              markerId: MarkerId(garajeData['id_garaje'].toString()),
              position: LatLng(lat, lng),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );
        }

        setState(() {});
      } else {
        throw Exception('Failed to load garajes');
      }
    } catch (e) {
      print('Error fetching garajes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white, // Color del icono blanco
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Parking System',
          style: TextStyle(color: Colors.white), // Color del texto blanco
        ),
        backgroundColor: Colors.red,
      ),
      drawer: Sidebar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-17.7833, -63.1667), 
          zoom: 12.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {},
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
