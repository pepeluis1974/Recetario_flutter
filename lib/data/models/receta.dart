// data/models/receta.dart - Modelo de datos para recetas
class Receta {
  final String id;
  final String nombre;
  final String? urlImagen;
  final List<Ingrediente> ingredientes;
  final List<String> pasos;
  final String? pais;
  final String? categoria;
  final String? contexto;
  final double? valoracion;
  final int? votos;
  final int comensales;
  final int tiempo; // en minutos
  final String dificultad; // 'Fácil', 'Media', 'Difícil'
  final String? coste; // 'Bajo', 'Medio', 'Alto'
  final Nutricion? valorNutricional;
  final List<String>? utensilios;
  final Map<String, dynamic>? traducciones;

  Receta({
    required this.id,
    required this.nombre,
    this.urlImagen,
    required this.ingredientes,
    required this.pasos,
    this.pais,
    this.categoria,
    this.contexto,
    this.valoracion,
    this.votos,
    required this.comensales,
    required this.tiempo,
    required this.dificultad,
    this.coste,
    this.valorNutricional,
    this.utensilios,
    this.traducciones,
  });

  // Convertir de JSON a objeto Receta
  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      urlImagen: json['urlImagen'],
      ingredientes: (json['ingredientes'] as List<dynamic>?)
          ?.map((ing) => Ingrediente.fromJson(ing))
          .toList() ?? [],
      pasos: (json['pasos'] as List<dynamic>?)?.cast<String>() ?? [],
      pais: json['pais'],
      categoria: json['categoria'],
      contexto: json['contexto'],
      valoracion: json['valoracion']?.toDouble(),
      votos: json['votos'],
      comensales: json['comensales'] ?? 1,
      tiempo: json['tiempo'] ?? 0,
      dificultad: json['dificultad'] ?? 'Media',
      coste: json['coste'],
      valorNutricional: json['valorNutricional'] != null 
          ? Nutricion.fromJson(json['valorNutricional']) 
          : null,
      utensilios: (json['utensilios'] as List<dynamic>?)?.cast<String>(),
      traducciones: json['traducciones'] != null 
          ? Map<String, dynamic>.from(json['traducciones']) 
          : null,
    );
  }

  // Convertir objeto Receta a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'urlImagen': urlImagen,
      'ingredientes': ingredientes.map((ing) => ing.toJson()).toList(),
      'pasos': pasos,
      'pais': pais,
      'categoria': categoria,
      'contexto': contexto,
      'valoracion': valoracion,
      'votos': votos,
      'comensales': comensales,
      'tiempo': tiempo,
      'dificultad': dificultad,
      'coste': coste,
      'valorNutricional': valorNutricional?.toJson(),
      'utensilios': utensilios,
      'traducciones': traducciones,
    };
  }
}

class Ingrediente {
  final String nombre;
  final double cantidad;
  final String unidad;

  Ingrediente({
    required this.nombre,
    required this.cantidad,
    required this.unidad,
  });

  factory Ingrediente.fromJson(Map<String, dynamic> json) {
    return Ingrediente(
      nombre: json['nombre'] ?? '',
      cantidad: json['cantidad']?.toDouble() ?? 0.0,
      unidad: json['unidad'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'cantidad': cantidad,
      'unidad': unidad,
    };
  }
}

class Nutricion {
  final double? calorias;
  final double? grasas;
  final double? proteinas;
  final double? hidratos;
  final Map<String, dynamic>? micronutrientes;

  Nutricion({
    this.calorias,
    this.grasas,
    this.proteinas,
    this.hidratos,
    this.micronutrientes,
  });

  factory Nutricion.fromJson(Map<String, dynamic> json) {
    return Nutricion(
      calorias: json['calorias']?.toDouble(),
      grasas: json['grasas']?.toDouble(),
      proteinas: json['proteinas']?.toDouble(),
      hidratos: json['hidratos']?.toDouble(),
      micronutrientes: json['micronutrientes'] != null 
          ? Map<String, dynamic>.from(json['micronutrientes']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calorias': calorias,
      'grasas': grasas,
      'proteinas': proteinas,
      'hidratos': hidratos,
      'micronutrientes': micronutrientes,
    };
  }
}