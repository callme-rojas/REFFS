import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/garaje.dart';

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
                image: AssetImage(
                    'assets/images/logo_univalle.png'), // Ruta de la imagen del garaje
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

  void _showReservationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservar Garaje'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Hora de entrada (timestamp)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Hora de salida (timestamp)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Precio ofrecido'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la lógica de la reserva
                Navigator.of(context).pop();
              },
              child: Text('Reservar'),
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
  }
}
