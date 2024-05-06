// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:reffs_parking/objects/auto.dart';
import 'package:reffs_parking/objects/garaje.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservasCard extends StatelessWidget {
  final Garaje garaje;

  ReservasCard({required this.garaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo_univalle.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dirección: ${garaje.direccion}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Latitud: ${garaje.lat}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitud: ${garaje.lng}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Dimensiones: ${garaje.dimensiones}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Características Adicionales: ${garaje.caracteristicasAdicionales}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showReservationDialog(context);
                  },
                  child: Text(
                    'Reservar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 176, 39, 39),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

void _showReservationDialog(BuildContext context) async {
  // Obtén el tiempo actual en formato UTC para start y end time
  DateTime startTime = DateTime.now().toUtc();
  DateTime endTime = startTime.add(Duration(hours: 1)); // Ejemplo: 1 hora después del startTime

  // Lista de horas disponibles (ejemplo)
  List<String> horasDisponibles = ['08:00', '09:00', '10:00'];

  // Precio de la reserva (ejemplo)
  double? price;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userId') ?? 0;

  // Instantiate ApiService with your base URL
  ApiService apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com');

  // Get the autos for the current user
  List<Auto> autos = await apiService.getAutosById(userId);

  // Extract the names of the autos
  List<String> nombresAutos = autos.map((auto) => auto.modelo).toList();

  // Variables to hold user inputs
  String? selectedAuto;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Reservar Garaje'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: selectedAuto,
                  items: nombresAutos.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAuto = newValue; // Update selectedAuto with nullable type
                    });
                  },
                  decoration: InputDecoration(labelText: 'Seleccionar Auto'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Precio ofrecido'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = double.tryParse(value);
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 176, 39, 39),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedAuto != null && price != null) {
                    int statusCode = await apiService.createReservation(
                      garaje.idGaraje,
                      autos.firstWhere((auto) => auto.modelo == selectedAuto).idAuto,
                      startTime.toIso8601String(), // Use ISO8601 string directly
                      endTime.toIso8601String(), // Use ISO8601 string directly
                      horasDisponibles,
                      price!,
                    );

                    if (statusCode == 201) {
                      Navigator.of(context).pop();
                      // Show success message or navigate to a success screen
                    } else {
                      // Handle reservation creation failure
                      // Show error message or handle accordingly
                    }
                  } else {
                    // Handle case where no auto is selected or price is invalid
                    // Show error message or handle accordingly
                  }
                },
                child: Text('Reservar',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 176, 39, 39),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
}
