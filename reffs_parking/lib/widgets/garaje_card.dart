import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/garaje.dart';
import 'package:reffs_parking/api/api_service.dart';

class GarajeCard extends StatefulWidget {
  final Garaje garaje;

  GarajeCard({required this.garaje});

  @override
  _GarajeCardState createState() => _GarajeCardState();
}

class _GarajeCardState extends State<GarajeCard> {
  late bool _disponibilidad;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _disponibilidad = widget.garaje.disponibilidad == 'DISPONIBLE';
    _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com');
  }

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
                image: AssetImage('assets/images/logo_univalle.png'), // Ruta de la imagen del garaje
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
                  'Dirección: ${widget.garaje.direccion}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Latitud: ${widget.garaje.lat}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitud: ${widget.garaje.lng}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Dimensiones: ${widget.garaje.dimensiones}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Características Adicionales: ${widget.garaje.caracteristicasAdicionales}',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      'Disponibilidad:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    Switch(
                      value: _disponibilidad,
                      activeTrackColor: Color.fromARGB(255, 176, 39, 39), // Color de la pista cuando está encendido
                      activeColor: Color.fromARGB(255, 176, 39, 39), // Color del botón cuando está encendido
                      onChanged: (value) {
                        setState(() {
                          _disponibilidad = value;
                        });
                        String newDisponibilidad =
                            value ? 'DISPONIBLE' : 'OCUPADO';
                        print('Disponibilidad cambiada a: $newDisponibilidad');
                        _updateDisponibilidad(newDisponibilidad); // Llama al método para actualizar la disponibilidad
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para actualizar la disponibilidad del garaje
  void _updateDisponibilidad(String newDisponibilidad) {
    if (newDisponibilidad != widget.garaje.disponibilidad) {
      if (newDisponibilidad == 'DISPONIBLE') {
        _apiService.setGarajeDisponible(widget.garaje.idGaraje);
      } else {
        _apiService.setGarajeOcupado(widget.garaje.idGaraje);
      }
    }
  }
}
