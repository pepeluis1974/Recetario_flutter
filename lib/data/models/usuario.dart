// data/models/usuario.dart
class Usuario {
  final String nombre;
  final List<String> intolerancias;
  final String tipoAlimentacion;
  final int comensales;
  final List<String> historialRecetas;

  Usuario({
    this.nombre = 'Usuario',
    this.intolerancias = const [],
    this.tipoAlimentacion = 'Omnívoro',
    this.comensales = 1,
    this.historialRecetas = const [],
  });

  // Método fromJson para compatibilidad
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'] ?? 'Usuario',
      intolerancias: (json['intolerancias'] as List<dynamic>?)?.cast<String>() ?? [],
      tipoAlimentacion: json['tipoAlimentacion'] ?? 'Omnívoro',
      comensales: json['comensales'] ?? 1,
      historialRecetas: (json['historialRecetas'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  // Método toJson para persistencia
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'intolerancias': intolerancias,
      'tipoAlimentacion': tipoAlimentacion,
      'comensales': comensales,
      'historialRecetas': historialRecetas,
    };
  }

  // Método copyWith para actualizaciones
  Usuario copyWith({
    String? nombre,
    List<String>? intolerancias,
    String? tipoAlimentacion,
    int? comensales,
    List<String>? historialRecetas,
  }) {
    return Usuario(
      nombre: nombre ?? this.nombre,
      intolerancias: intolerancias ?? this.intolerancias,
      tipoAlimentacion: tipoAlimentacion ?? this.tipoAlimentacion,
      comensales: comensales ?? this.comensales,
      historialRecetas: historialRecetas ?? this.historialRecetas,
    );
  }
}