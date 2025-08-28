// data/services/db_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recetario_app/data/models/receta.dart';
import 'package:recetario_app/data/services/logging_service.dart';
import 'package:recetario_app/data/models/usuario.dart';
  

class DbService {
  static List<Receta> _recetasCache = [];
  static bool _isInitialized = false;

  /// Inicializar el servicio - Carga desde JSON para Fase 1
  static Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      LoggingService.info('📦 Iniciando DbService (modo JSON)');
      
      // Cargar recetas desde el archivo JSON
      _recetasCache = await _cargarRecetasDesdeJSON();
      
      _isInitialized = true;
      LoggingService.info('✅ DbService inicializado con ${_recetasCache.length} recetas');
    } catch (e) {
      LoggingService.error('❌ Error al inicializar DbService: $e');
      rethrow;
    }
  }

  /// Cargar recetas desde el archivo JSON en assets
  static Future<List<Receta>> _cargarRecetasDesdeJSON() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/recetas.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> recetasJson = jsonData['recetas'];
      
      return recetasJson.map((json) => Receta.fromJson(json)).toList();
    } catch (e) {
      LoggingService.error('Error al cargar JSON: $e');
      // Fallback a recetas de ejemplo si hay error
      return _getRecetasEjemplo();
    }
  }

  /// Recetas de ejemplo por si falla la carga del JSON
  static List<Receta> _getRecetasEjemplo() {
    return [
      Receta(
        id: '1',
        nombre: 'Ensalada César',
        ingredientes: [
          Ingrediente(nombre: 'Lechuga romana', cantidad: 1, unidad: 'unidad'),
          Ingrediente(nombre: 'Pollo', cantidad: 200, unidad: 'g'),
        ],
        pasos: [
          'Lavar y cortar la lechuga',
          'Cocinar el pollo y cortarlo en trozos',
          'Mezclar todos los ingredientes'
        ],
        comensales: 2,
        tiempo: 20,
        dificultad: 'Fácil',
      ),
      Receta(
        id: '2',
        nombre: 'Pasta Carbonara',
        ingredientes: [
          Ingrediente(nombre: 'Pasta', cantidad: 250, unidad: 'g'),
          Ingrediente(nombre: 'Huevos', cantidad: 2, unidad: 'unidades'),
        ],
        pasos: [
          'Cocinar la pasta al dente',
          'Preparar la salsa',
          'Mezclar todo y servir'
        ],
        comensales: 3,
        tiempo: 25,
        dificultad: 'Media',
      ),
    ];
  }

  // --- OPERACIONES CRUD (Simuladas para JSON) ---

  /// Obtener todas las recetas
  static Future<List<Receta>> getAllRecetas() async {
    _verificarInicializacion();
    return _recetasCache;
  }

  /// Obtener receta por ID
  static Future<Receta?> getReceta(String id) async {
    _verificarInicializacion();
    try {
      return _recetasCache.firstWhere((receta) => receta.id == id);
    } catch (e) {
      LoggingService.warning('Receta con id $id no encontrada');
      return null;
    }
  }

  /// Buscar recetas por query de texto
  static Future<List<Receta>> queryRecetas({
    String? query,
    int page = 1,
    int pageSize = 20,
  }) async {
    _verificarInicializacion();
    
    List<Receta> resultados = _recetasCache;
    
    // Aplicar filtro de búsqueda si existe
    if (query != null && query.isNotEmpty) {
      resultados = resultados.where((receta) =>
        receta.nombre.toLowerCase().contains(query.toLowerCase()) ||
        receta.ingredientes.any((ing) => 
          ing.nombre.toLowerCase().contains(query.toLowerCase()))
      ).toList();
    }
    
    // Aplicar paginación
    return _aplicarPaginacion(resultados, page, pageSize);
  }

  /// Búsqueda avanzada (simplificada para Fase 1)
  static Future<List<Receta>> searchRecetas({
    List<String>? ingredientesIncluidos,
    int? tiempoMaximo,
    String? dificultad,
  }) async {
    _verificarInicializacion();
    
    List<Receta> resultados = _recetasCache;
    
    // Filtrar por ingredientes
    if (ingredientesIncluidos != null && ingredientesIncluidos.isNotEmpty) {
      resultados = resultados.where((receta) =>
        ingredientesIncluidos.any((ingrediente) =>
          receta.ingredientes.any((ing) => 
            ing.nombre.toLowerCase().contains(ingrediente.toLowerCase())))
      ).toList();
    }
    
    // Filtrar por tiempo máximo
    if (tiempoMaximo != null) {
      resultados = resultados.where((receta) => 
        receta.tiempo <= tiempoMaximo).toList();
    }
    
    // Filtrar por dificultad
    if (dificultad != null) {
      resultados = resultados.where((receta) => 
        receta.dificultad == dificultad).toList();
    }
    
    return resultados;
  }

  // --- MÉTODOS DE UTILIDAD ---

  /// Aplicar paginación a los resultados
  static List<Receta> _aplicarPaginacion(List<Receta> recetas, int page, int pageSize) {
    final startIndex = (page - 1) * pageSize;
    if (startIndex >= recetas.length) return [];
    
    final endIndex = startIndex + pageSize;
    return recetas.sublist(
      startIndex,
      endIndex > recetas.length ? recetas.length : endIndex,
    );
  }

  /// Verificar que el servicio esté inicializado
  static void _verificarInicializacion() {
    if (!_isInitialized) {
      throw Exception('DbService no inicializado. Llama a init() primero.');
    }
  }

  // --- MÉTODOS PARA FASES FUTURAS (Placeholders) ---

  /// Guardar receta (para Fase 3 - CRUD)
  static Future<void> upsertReceta(Receta receta) async {
    LoggingService.info('📝 upsertReceta() - Disponible en Fase 3');
    // Implementación en Fase 3 con Hive
  }

  /// Eliminar receta (para Fase 3 - CRUD)
  static Future<void> deleteReceta(String id) async {
    LoggingService.info('🗑️ deleteReceta() - Disponible en Fase 3');
    // Implementación en Fase 3 con Hive
  }

  /// Operaciones de usuario (para Fase 2-3)
  static Future<void> saveUsuario(Usuario usuario) async {
    LoggingService.info('👤 saveUsuario() - Disponible en Fase 2');
  }

  static Future<Usuario?> getUsuarioActivo() async {
    LoggingService.info('👤 getUsuarioActivo() - Disponible en Fase 2');
    return null;
  }

  /// Operaciones de favoritos (para Fase 2)
  static Future<void> addFavorito(String recetaId) async {
    LoggingService.info('❤️ addFavorito() - Disponible en Fase 2');
  }

  static Future<List<String>> getFavoritos() async {
    LoggingService.info('❤️ getFavoritos() - Disponible en Fase 2');
    return [];
  }
}