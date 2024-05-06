class Reservacion {
  final int idReservacion;
  final int fkIdGaraje;
  final int fkIdAuto;
  final DateTime horaInicio;
  final DateTime horaFin;
  final List<String> horasDisponibles;
  final String estado;
  final double precio;

  Reservacion({
    required this.idReservacion,
    required this.fkIdGaraje,
    required this.fkIdAuto,
    required this.horaInicio,
    required this.horaFin,
    required this.horasDisponibles,
    required this.estado,
    required this.precio,
  });

  factory Reservacion.fromJson(Map<String, dynamic> json) {
    return Reservacion(
      idReservacion: json['id_reservacion'] ?? 0,
      fkIdGaraje: json['fk_id_garaje'] ?? 0,
      fkIdAuto: json['fk_id_auto'] ?? 0,
      horaInicio: DateTime.parse(json['horainicio'] ?? ''),
      horaFin: DateTime.parse(json['horafin'] ?? ''),
      horasDisponibles: List<String>.from(json['horasdisponibles'] ?? []),
      estado: json['estado'] ?? '',
      precio: double.parse(json['precio'] ?? '0.0'),
    );
  }
}
