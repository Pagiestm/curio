import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Configuration du système de logging
class AppLogger {
  static final Logger _logger = Logger('Curio');

  static void init() {
    Logger.root.level = Level.INFO;
    Logger.root.onRecord.listen((record) {
      // En développement, utiliser debugPrint pour les logs
      // En production, utiliser un service de logging
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
      if (record.error != null) {
        debugPrint('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint('StackTrace: ${record.stackTrace}');
      }
    });
  }

  static Logger get logger => _logger;

  static void info(String message) => _logger.info(message);
  static void warning(String message) => _logger.warning(message);
  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.severe(message, error, stackTrace);
  static void debug(String message) => _logger.fine(message);
}
