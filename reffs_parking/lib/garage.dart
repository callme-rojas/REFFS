class Garage {
  final Dimensions dimensions;
  final String ubicacion;
  final String referencias;

  Garage({
    required this.dimensions,
    required this.ubicacion,
    required this.referencias,
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
    return 'Altura: $altura, Ancho: $ancho, Largo: $largo';
  }
}