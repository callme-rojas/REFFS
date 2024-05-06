import 'package:flutter/material.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:reffs_parking/objects/reservacion.dart';

class ReservasPendientesCard extends StatelessWidget {
  final Reservacion reserva;
  final ApiService apiService; // Agrega el ApiService como parámetro

  ReservasPendientesCard({required this.reserva, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Reservación: ${reserva.idReservacion}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ID Garaje: ${reserva.fkIdGaraje}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'ID Auto: ${reserva.fkIdAuto}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Hora Inicio: ${reserva.horaInicio}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Hora Fin: ${reserva.horaFin}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Estado: ${reserva.estado}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Precio: \$${reserva.precio.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Llama a la función para confirmar la reservación
                        apiService.confirmReservacion(reserva.idReservacion);
                      },
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Llama a la función para rechazar la reservación
                        apiService.rejectReservacion(reserva.idReservacion);
                      },
                      child: Text(
                        'Rechazar',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
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
}
