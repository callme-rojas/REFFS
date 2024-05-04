import 'package:flutter/material.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCarPage extends StatefulWidget {
  @override
  _RegisterCarPageState createState() => _RegisterCarPageState();
}

class _RegisterCarPageState extends State<RegisterCarPage> {
  final TextEditingController placaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController dimensionesController = TextEditingController();

  final ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com');

Future<void> _registerCar() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final usuarioId = prefs.getInt('userId') ?? 0; // Obtener usuarioId de SharedPreferences, si no está disponible, asignar 0

  if (usuarioId == 0) {
    // Manejar el caso donde usuarioId no está disponible
    print('Error: UsuarioId no encontrado en SharedPreferences.');
    return;
  }

  final placa = placaController.text;
  final modelo = modeloController.text;
  final dimensiones = dimensionesController.text;

  final response = await _apiService.addAuto(usuarioId, placa, modelo, dimensiones);

  if (response.statusCode == 201) {
    // Registro exitoso, puedes manejar la respuesta aquí
    print('Auto registrado exitosamente.');
  } else {
    // Manejo de errores si es necesario
    print('Error al registrar el auto. Código de estado: ${response.statusCode}');
    print('Mensaje: ${response.body}');
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Añadir Auto'),
      backgroundColor: const Color.fromARGB(255, 176, 39, 39), // Color principal
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: placaController,
            decoration: InputDecoration(
              labelText: 'Placa',
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
            controller: modeloController,
            decoration: InputDecoration(
              labelText: 'Modelo',
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
            controller: dimensionesController,
            decoration: InputDecoration(
              labelText: 'Dimensiones',
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
          ElevatedButton(
            onPressed: _registerCar,
            child: const Text('Registrar Auto',style: TextStyle(fontSize: 14,color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 176, 39, 39), // Color principal para el fondo del botón
            ),
          ),
        ],
      ),
    ),
  );
}
}

