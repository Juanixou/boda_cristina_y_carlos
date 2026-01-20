import 'package:logger/logger.dart';

/// Logger global para toda la aplicación
/// 
/// Uso:
/// ```dart
/// AppLogger.info('Mensaje informativo');
/// AppLogger.error('Error ocurrido', error: e);
/// AppLogger.debug('Datos de debug', data: someData);
/// ```
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Log de nivel info
  static void info(String message, {dynamic data}) {
    _logger.i(message, error: null, stackTrace: null);
    if (data != null) {
      _logger.d(data);
    }
  }

  /// Log de nivel debug
  static void debug(String message, {dynamic data}) {
    _logger.d(message);
    if (data != null) {
      _logger.d(data);
    }
  }

  /// Log de nivel warning
  static void warning(String message, {dynamic data}) {
    _logger.w(message);
    if (data != null) {
      _logger.d(data);
    }
  }

  /// Log de nivel error
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log de nivel verbose
  static void verbose(String message, {dynamic data}) {
    _logger.t(message);
    if (data != null) {
      _logger.d(data);
    }
  }
}
