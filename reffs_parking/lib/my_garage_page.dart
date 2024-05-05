import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/garaje.dart';
import 'package:reffs_parking/widgets/garaje_card.dart';
import 'package:reffs_parking/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGaragePage extends StatefulWidget {
  @override
  _MyGaragePageState createState() => _MyGaragePageState();
}

class _MyGaragePageState extends State<MyGaragePage> {
  ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com'); // Reemplaza 'https://tu_api.com' con la URL base de tu API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Garajes'),
      ),
      body: FutureBuilder<List<Garaje>>(
        future: _getGarajes(),
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
                  return GarajeCard(garaje: garajes[index]);
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

  Future<List<Garaje>> _getGarajes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('userId') ?? 0;

    if (usuarioId == 0) {
      // Manejar el caso donde usuarioId no está disponible
      print('Error: UsuarioId no encontrado en SharedPreferences.');
      return [];
    }

    return _apiService.getGarajesById(usuarioId);
  }
}
