// data/providers/receta_provider.dart (actualizado)
import 'package:flutter/foundation.dart';
import 'package:recetario_app/data/models/receta.dart';
import 'package:recetario_app/data/services/db_service.dart';
import 'package:recetario_app/data/services/logging_service.dart';

class RecetaProvider with ChangeNotifier {
  List<Receta> _recetas = [];
  List<Receta> _recetasFiltradas = [];
  bool _isLoading = false;
  String? _error;

  List<Receta> get recetas => _recetasFiltradas;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> init() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Inicializar DbService primero
      await DbService.init();
      
      // Cargar recetas desde DbService (que ahora usa JSON)
      _recetas = await DbService.getAllRecetas();
      _recetasFiltradas = _recetas;
      
      _error = null;
      LoggingService.info('✅ ${_recetas.length} recetas cargadas');
    } catch (e) {
      _error = 'Error al cargar recetas: $e';
      LoggingService.error(_error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void filtrarRecetas(String query) {
    if (query.isEmpty) {
      _recetasFiltradas = _recetas;
    } else {
      _recetasFiltradas = _recetas
          .where((r) => r.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Métodos simplificados para la Fase 1
  Receta? getById(String id) {
    try {
      return _recetas.firstWhere((r) => r.id == id);
    } catch (e) {
      LoggingService.error('Error al obtener receta por ID: $e');
      return null;
    }
  }
}