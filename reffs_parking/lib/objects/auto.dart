class Auto {
  final int idAuto;
  final int fkIdUsuario;
  final String placa;
  final String modelo;
  final String dimensiones;
  bool ocupado;

  Auto({
    required this.idAuto,
    required this.fkIdUsuario,
    required this.placa,
    required this.modelo,
    required this.dimensiones,
    this.ocupado = false, // Por defecto, el auto está disponible (no ocupado)
  });

  factory Auto.fromJson(Map<String, dynamic> json) {
    return Auto(
      idAuto: json['id_auto'] ?? 0,
      fkIdUsuario: json['fk_id_usuario'] ?? 0,
      placa: json['placa'] ?? '',
      modelo: json['modelo'] ?? '',
      dimensiones: json['dimensiones'] ?? '',
    );
  }
}
