import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterGaragePage extends StatefulWidget {
  @override
  _RegisterGaragePageState createState() => _RegisterGaragePageState();
}

class _RegisterGaragePageState extends State<RegisterGaragePage> {
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController latitudController = TextEditingController();
  final TextEditingController longitudController = TextEditingController();
  final TextEditingController dimensionesController = TextEditingController();
  final TextEditingController caracteristicasController = TextEditingController();
  final TextEditingController disponibilidadController = TextEditingController();

  final ApiService _apiService =
      ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com');

  // Función para obtener la ubicación actual del dispositivo
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Servicios de ubicación no habilitados, mostrar un mensaje al usuario
      print('Servicios de ubicación deshabilitados.');
      return;
    }

    // Solicitar permisos de ubicación al usuario
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permiso denegado por el usuario, mostrar un mensaje al usuario
      print('Permiso de ubicación denegado.');
      return;
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudController.text = position.latitude.toString();
      longitudController.text = position.longitude.toString();
    });
  }

  Future<void> _registerGarage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('userId') ?? 0;

    if (usuarioId == 0) {
      print('Error: UsuarioId no encontrado en SharedPreferences.');
      return;
    }

    final direccion = direccionController.text;
    final latitud = latitudController.text;
    final longitud = longitudController.text;
    final dimensiones = dimensionesController.text;
    final caracteristicas = caracteristicasController.text;
    final disponibilidad = disponibilidadController.text;

    final response = await _apiService.addGaraje(
      direccion,
      latitud,
      longitud,
      dimensiones,
      caracteristicas,
      disponibilidad,
    );

    if (response == 201) {
      print('Garaje registrado exitosamente.');
    } else {
      print('Error al registrar el garaje. Código de estado: $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Garaje'),
        backgroundColor: const Color.fromARGB(255, 176, 39, 39),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: direccionController,
              decoration: InputDecoration(
                labelText: 'Dirección',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: latitudController,
              decoration: InputDecoration(
                labelText: 'Latitud',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: longitudController,
              decoration: InputDecoration(
                labelText: 'Longitud',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dimensionesController,
              decoration: InputDecoration(
                labelText: 'Dimensiones',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: caracteristicasController,
              decoration: InputDecoration(
                labelText: 'Características Adicionales',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: disponibilidadController,
              decoration: InputDecoration(
                labelText: 'Disponibilidad',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text(
                'Obtener Ubicación Actual',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 176, 39, 39),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerGarage,
              child: const Text(
                'Registrar Garaje',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 176, 39, 39),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
