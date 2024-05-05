class Auto {
  final int usuarioId;
  final String placa;
  final String modelo;
  final String dimensiones;
  bool ocupado;

  Auto({
    required this.usuarioId,
    required this.placa,
    required this.modelo,
    required this.dimensiones,
    this.ocupado = false, // Por defecto, el auto está disponible (no ocupado)
  });

  factory Auto.fromJson(Map<String, dynamic> json) {
    return Auto(
      usuarioId: json['usuarioId'] ?? 0,
      placa: json['placa'] ?? '',
      modelo: json['modelo'] ?? '',
      dimensiones: json['dimensiones'] ?? '',
    );
  }
}