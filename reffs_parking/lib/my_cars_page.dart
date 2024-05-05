import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/auto.dart'; // Asegúrate de importar la clase Auto
import 'package:reffs_parking/widgets/auto_card.dart'; // Asegúrate de importar el widget AutoCard
import 'package:reffs_parking/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAutoPage extends StatefulWidget {
  @override
  _MyAutoPageState createState() => _MyAutoPageState();
}

class _MyAutoPageState extends State<MyAutoPage> {
  ApiService _apiService = ApiService(baseUrl: 'https://parkingsystem-hjcb.onrender.com'); // Reemplaza 'https://tu_api.com' con la URL base de tu API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Autos'),
      ),
      body: FutureBuilder<List<Auto>>(
        future: _getAutos(),
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
            List<Auto>? autos = snapshot.data;
            if (autos != null && autos.isNotEmpty) {
              return ListView.builder(
                itemCount: autos.length,
                itemBuilder: (context, index) {
                  return AutoCard(auto: autos[index]);
                },
              );
            } else {
              return Center(
                child: Text('No se encontraron autos'),
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Auto>> _getAutos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('userId') ?? 0;

    if (usuarioId == 0) {
      // Manejar el caso donde usuarioId no está disponible
      print('Error: UsuarioId no encontrado en SharedPreferences.');
      return [];
    }

    return _apiService.getAutosById(usuarioId);
  }
}
