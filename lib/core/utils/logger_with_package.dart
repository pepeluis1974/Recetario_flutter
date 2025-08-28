// core/utils/logger_with_package.dart
import 'package:logger/logger.dart' as external_logger;

class LoggerWithPackage {
  static external_logger.Logger? _logger;
  
  static void init() {
    _logger = external_logger.Logger(
      printer: external_logger.PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );
  }
  
  static void d(String message) {
    _logger?.d(message);
  }
  
  static void i(String message) {
    _logger?.i(message);
  }
  
  static void w(String message) {
    _logger?.w(message);
  }
  
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }
}