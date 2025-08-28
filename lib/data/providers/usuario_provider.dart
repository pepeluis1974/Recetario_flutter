// data/providers/usuario_provider.dart
import 'package:flutter/foundation.dart';
import 'package:recetario_app/data/models/usuario.dart';
import 'package:recetario_app/data/services/logging_service.dart';

class UsuarioProvider with ChangeNotifier {
  Usuario _usuario = Usuario(nombre: 'Usuario');
  bool _isLoading = false;
  String? _error;

  Usuario get usuario => _usuario;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Inicializar el provider - Versión simplificada para Fase 1
  Future<void> init() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Para la Fase 1, simplemente usamos un usuario por defecto
      // En fases posteriores se cargará desde la base de datos
      _usuario = Usuario(nombre: 'Usuario');
      
      _error = null;
      LoggingService.info('UsuarioProvider inicializado');
    } catch (e) {
      _error = 'Error al inicializar usuario: $e';
      LoggingService.error(_error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Actualizar perfil de usuario - Versión simplificada
  Future<bool> updatePerfil({
    String? nombre,
    List<String>? intolerancias,
    String? tipoAlimentacion,
    int? comensales,
  }) async {
    try {
      final usuarioActualizado = Usuario(
        nombre: nombre ?? _usuario.nombre,
        intolerancias: intolerancias ?? _usuario.intolerancias,
        tipoAlimentacion: tipoAlimentacion ?? _usuario.tipoAlimentacion,
        comensales: comensales ?? _usuario.comensales,
        historialRecetas: _usuario.historialRecetas,
      );
      
      _usuario = usuarioActualizado;
      notifyListeners();
      
      LoggingService.info('Perfil actualizado: ${usuarioActualizado.nombre}');
      return true;
    } catch (e) {
      LoggingService.error('Error al actualizar perfil: $e');
      return false;
    }
  }

  /// Añadir receta al historial - Versión simplificada
  void addToHistorial(String recetaId) {
    try {
      // Evitar duplicados
      if (_usuario.historialRecetas.contains(recetaId)) {
        _usuario.historialRecetas.remove(recetaId);
      }
      
      // Añadir al inicio
      _usuario.historialRecetas.insert(0, recetaId);
      
      // Limitar el historial a las últimas 20 recetas
      if (_usuario.historialRecetas.length > 20) {
        _usuario.historialRecetas.removeLast();
      }
      
      notifyListeners();
      LoggingService.info('Receta $recetaId añadida al historial');
    } catch (e) {
      LoggingService.error('Error al añadir al historial: $e');
    }
  }

  /// Obtener restricciones del usuario para filtrado
  Map<String, dynamic> getRestricciones() {
    return {
      'intolerancias': _usuario.intolerancias,
      'tipoAlimentacion': _usuario.tipoAlimentacion,
    };
  }

  /// Reiniciar usuario a valores por defecto
  void resetUsuario() {
    _usuario = Usuario(nombre: 'Usuario');
    notifyListeners();
    LoggingService.info('Usuario reiniciado a valores por defecto');
  }

  /// Verificar si el usuario tiene alguna intolerancia específica
  bool tieneIntolerancia(String intolerancia) {
    return _usuario.intolerancias.contains(intolerancia);
  }

  /// Añadir intolerancia
  void addIntolerancia(String intolerancia) {
    if (!_usuario.intolerancias.contains(intolerancia)) {
      _usuario.intolerancias.add(intolerancia);
      notifyListeners();
      LoggingService.info('Intolerancia añadida: $intolerancia');
    }
  }

  /// Eliminar intolerancia
  void removeIntolerancia(String intolerancia) {
    if (_usuario.intolerancias.contains(intolerancia)) {
      _usuario.intolerancias.remove(intolerancia);
      notifyListeners();
      LoggingService.info('Intolerancia eliminada: $intolerancia');
    }
  }
}