import 'package:wedding_web/data/datasources/rsvp_datasource.dart';
import 'package:wedding_web/models/rsvp_form.dart';
import 'package:wedding_web/utils/logger.dart';

class RSVPRepository {
  final RSVPDataSource dataSource;

  RSVPRepository({required this.dataSource});

  Future<void> submitRSVP(RSVPForm form) async {
    AppLogger.info('📋 Repository: Preparando envío de RSVP');
    AppLogger.debug('📋 Datos del formulario', data: form.toJson());
    
    try {
      await dataSource.submitRSVP(form.toJson());
      AppLogger.info('✅ Repository: RSVP enviado exitosamente');
    } catch (e, stackTrace) {
      AppLogger.error(
        '❌ Repository: Error al enviar RSVP',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

