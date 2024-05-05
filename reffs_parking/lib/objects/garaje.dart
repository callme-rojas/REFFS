class Garaje {
  final int idGaraje;
  final int fkIdUsuario;
  final String direccion;
  final double lat;
  final double lng;
  final String dimensiones;
  final String caracteristicasAdicionales;
  late final String disponibilidad;

  Garaje({
    required this.idGaraje,
    required this.fkIdUsuario,
    required this.direccion,
    required this.lat,
    required this.lng,
    required this.dimensiones,
    required this.caracteristicasAdicionales,
    required this.disponibilidad,
  });

  factory Garaje.fromJson(Map<String, dynamic> json) {
    return Garaje(
      idGaraje: json['id_garaje'] ?? 0,
      fkIdUsuario: json['fk_id_usuario'] ?? 0,
      direccion: json['direccion'] ?? '',
      lat: double.parse(json['lat'] ?? '0.0'),
      lng: double.parse(json['lng'] ?? '0.0'),
      dimensiones: json['dimensiones'] ?? '',
      caracteristicasAdicionales: json['caracteristicasadicionales'] ?? '',
      disponibilidad: json['disponibilidad'] ?? '',
    );
  }
}
