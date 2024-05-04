import 'package:flutter/material.dart';
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

  final ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com');

  Future<void> _registerGarage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('userId') ?? 0; // Obtener usuarioId de SharedPreferences, si no está disponible, asignar 0

    if (usuarioId == 0) {
      // Manejar el caso donde usuarioId no está disponible
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
      // Registro exitoso, puedes manejar la respuesta aquí
      print('Garaje registrado exitosamente.');
    } else {
      // Manejo de errores si es necesario
      print('Error al registrar el garaje. Código de estado: $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Garaje'),
        backgroundColor: const Color.fromARGB(255, 176, 39, 39), // Color principal
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
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)), // Color principal para el texto del label
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)), // Color principal para el borde enfocado
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)), // Color principal para el borde habilitado
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: latitudController,
              decoration: InputDecoration(
                labelText: 'Latitud',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: longitudController,
              decoration: InputDecoration(
                labelText: 'Longitud',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dimensionesController,
              decoration: InputDecoration(
                labelText: 'Dimensiones',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: caracteristicasController,
              decoration: InputDecoration(
                labelText: 'Características Adicionales',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: disponibilidadController,
              decoration: InputDecoration(
                labelText: 'Disponibilidad',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 176, 39, 39)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: const Color.fromARGB(255, 176, 39, 39)),
                ),
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
