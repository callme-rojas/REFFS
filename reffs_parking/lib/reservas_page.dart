import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/garaje.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:reffs_parking/widgets/reservas_card.dart';

class ReservasPage extends StatefulWidget {
  @override
  _ReservasPage createState() => _ReservasPage();
}

class _ReservasPage extends State<ReservasPage> {
  ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com'); // Reemplaza 'https://tu_api.com' con la URL base de tu API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garajes Disponibles'),
      ),
      body: FutureBuilder<List<Garaje>>(
        future: _getGarajesDisponibles(),
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
            List<Garaje>? garajes = snapshot.data;
            if (garajes != null && garajes.isNotEmpty) {
              return ListView.builder(
                itemCount: garajes.length,
                itemBuilder: (context, index) {
                  return ReservasCard(garaje: garajes[index]);
                },
              );
            } else {
              return Center(
                child: Text('No se encontraron garajes'),
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Garaje>> _getGarajesDisponibles() async {
    return _apiService.getGarajesDisponibles();
  }
}
