import 'package:flutter/material.dart';
import 'package:reffs_parking/objects/auto.dart';

class AutoCard extends StatefulWidget {
  final Auto auto;

  AutoCard({required this.auto});

  @override
  _AutoCardState createState() => _AutoCardState();
}

class _AutoCardState extends State<AutoCard> {
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
                    'assets/images/logo_univalle.png'), // Ruta de la imagen del auto
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
                  'Placa: ${widget.auto.placa}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Modelo: ${widget.auto.modelo}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Dimensiones: ${widget.auto.dimensiones}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
