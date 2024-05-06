import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/reservacion.dart'; // Importa tu clase Reservacion
import 'package:reffs_parking/widgets/reservas_pendientes_card.dart'; // Importa tu widget ReservasPendientesCard
import 'package:reffs_parking/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa tu ApiService para obtener las reservaciones pendientes

class ReservasPendientesPage extends StatefulWidget {
  @override
  _ReservasPendientesPageState createState() => _ReservasPendientesPageState();
}

class _ReservasPendientesPageState extends State<ReservasPendientesPage> {
  ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com'); // Reemplaza la URL base según tu API

  Future<List<Reservacion>> _getReservacionesPendientes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('userId') ?? 0;

    if (usuarioId == 0) {
      // Manejar el caso donde usuarioId no está disponible
      print('Error: UsuarioId no encontrado en SharedPreferences.');
      return [];
    }
    return _apiService.getReservacionesPendientes(usuarioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas Pendientes'),
      ),
      body: FutureBuilder<List<Reservacion>>(
        future: _getReservacionesPendientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          } else {
            List<Reservacion>? reservaciones = snapshot.data;
            if (reservaciones != null && reservaciones.isNotEmpty) {
              return ListView.builder(
                itemCount: reservaciones.length,
                itemBuilder: (context, index) {
                  return ReservasPendientesCard(reserva: reservaciones[index], apiService: _apiService,); // Utiliza el card aquí
                },
              );
            } else {
              return Center(
                child: Text('No hay reservaciones pendientes'),
              );
            }
          }
        },
      ),
    );
  }
}
