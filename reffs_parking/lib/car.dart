class Car {
  final String color;
  final String modelo;
  final int anio;
  final String nroplaca;
  final Dimensions dimensions;

  Car({
    required this.color,
    required this.modelo,
    required this.anio,
    required this.nroplaca,
    required this.dimensions,
  });
}

class Dimensions {
  final double altura;
  final double ancho;
  final double largo;

  Dimensions({
    required this.altura,
    required this.ancho,
    required this.largo,
  });

  @override
  String toString() {
    return 'altura: $altura cm, ancho: $ancho cm, Length: $largo cm';
  }
}
