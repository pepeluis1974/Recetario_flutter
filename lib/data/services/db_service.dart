// data/services/db_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recetario_app/data/models/receta.dart';
import 'package:recetario_app/data/services/logging_service.dart';

class DbService {
  static List<Receta> _recetasCache = [];
  static bool _isInitialized = false;

  /// Inicializar el servicio - Carga desde JSON
  static Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      LoggingService.info('📦 Iniciando DbService - Cargando desde JSON');
      
      // FORZAR carga desde JSON
      _recetasCache = await _cargarRecetasDesdeJSON();
      
      // Verificar si se cargaron recetas
      if (_recetasCache.isEmpty) {
        LoggingService.warning('⚠️ JSON vacío, usando datos de ejemplo');
        _recetasCache = _getRecetasEjemplo();
      }
      
      _isInitialized = true;
      LoggingService.info('✅ DbService inicializado con ${_recetasCache.length} recetas');
      
    } catch (e) {
      LoggingService.error('❌ Error grave en DbService.init(): $e');
      // En caso de error crítico, usar ejemplos
      _recetasCache = _getRecetasEjemplo();
      _isInitialized = true;
    }
  }

  /// Cargar recetas desde JSON con verificación exhaustiva
  static Future<List<Receta>> _cargarRecetasDesdeJSON() async {
    try {
      LoggingService.info('📖 Intentando cargar JSON desde assets...');
      
      // Cargar el archivo JSON
      final String jsonString = await rootBundle.loadString('assets/data/recetas.json');
      LoggingService.info('📄 JSON cargado, tamaño: ${jsonString.length} caracteres');
      
      // Decodificar JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Verificar estructura
      if (!jsonData.containsKey('recetas')) {
        LoggingService.error('❌ JSON no tiene clave "recetas"');
        return [];
      }
      
      final List<dynamic> recetasJson = jsonData['recetas'];
      LoggingService.info('📊 Encontradas ${recetasJson.length} recetas en JSON');
      
      // Convertir a objetos Receta
      final List<Receta> recetas = [];
      
      for (var i = 0; i < recetasJson.length; i++) {
        try {
          final receta = Receta.fromJson(recetasJson[i]);
          recetas.add(receta);
          LoggingService.debug('✅ Receta ${i + 1}: ${receta.nombre}');
        } catch (e) {
          LoggingService.error('❌ Error en receta ${i + 1}: $e');
        }
      }
      
      return recetas;
      
    } catch (e) {
      LoggingService.error('❌ Error crítico al cargar JSON: $e');
      return [];
    }
  }

  /// Recetas de ejemplo SOLO si falla el JSON
  static List<Receta> _getRecetasEjemplo() {
    LoggingService.warning('⚠️ Usando recetas de ejemplo de emergencia');
    return [
      Receta(
        id: 'demo-1',
        nombre: 'Ensalada Demo',
        ingredientes: [
          Ingrediente(nombre: 'Lechuga', cantidad: 1, unidad: 'unidad'),
          Ingrediente(nombre: 'Tomate', cantidad: 2, unidad: 'unidades'),
        ],
        pasos: ['Preparar ensalada demo'],
        comensales: 2,
        tiempo: 10,
        dificultad: 'Fácil',
      ),
      Receta(
        id: 'demo-2', 
        nombre: 'Pasta Demo',
        ingredientes: [
          Ingrediente(nombre: 'Pasta', cantidad: 200, unidad: 'g'),
          Ingrediente(nombre: 'Salsa', cantidad: 100, unidad: 'ml'),
        ],
        pasos: ['Cocinar pasta demo'],
        comensales: 2,
        tiempo: 15,
        dificultad: 'Fácil',
      )
    ];
  }

  /// Obtener todas las recetas (DEBUG)
  static Future<List<Receta>> getAllRecetas() async {
    _verificarInicializacion();
    
    // DEBUG: Verificar qué recetas tenemos
    LoggingService.info('📋 getAllRecetas() - Devolviendo ${_recetasCache.length} recetas');
    for (var receta in _recetasCache) {
      LoggingService.debug('🍳 ${receta.id}: ${receta.nombre}');
    }
    
    return _recetasCache;
  }

  // ... resto de métodos ...

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
