import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:wedding_web/utils/logger.dart';

/// Envía datos a un Google Apps Script Web App usando un formulario HTML
/// oculto + iframe, en vez de `http.post`, para evitar los problemas de CORS
/// que Apps Script impone a las peticiones fetch/XHR normales.
class GoogleAppsScriptClient {
  static Future<void> submitViaHiddenForm({
    required String url,
    required Map<String, dynamic> data,
    String label = 'GoogleAppsScript',
  }) async {
    AppLogger.info('📤 [$label] Iniciando envío', data: data);

    try {
      final jsonData = jsonEncode(data);
      final completer = Completer<void>();

      final form = html.FormElement()
        ..method = 'POST'
        ..action = url
        ..enctype = 'application/x-www-form-urlencoded'
        ..style.display = 'none';

      // IMPORTANTE: El nombre del campo debe ser "data" para que el script lo encuentre
      final dataInput = html.InputElement(type: 'hidden')
        ..name = 'data'
        ..value = Uri.encodeComponent(jsonData);
      form.append(dataInput);
      html.document.body!.append(form);

      final iframe = html.IFrameElement()
        ..name = '${label}_iframe_${DateTime.now().millisecondsSinceEpoch}'
        ..style.display = 'none';
      form.target = iframe.name;
      html.document.body!.append(iframe);

      // No podemos leer el contenido del iframe debido a CORS,
      // pero si el iframe carga, significa que la petición se procesó.
      iframe.onLoad.listen((event) {
        AppLogger.info('📥 [$label] Respuesta recibida (formulario procesado)');
        if (!completer.isCompleted) {
          completer.complete();
        }
        Timer(const Duration(milliseconds: 500), () {
          form.remove();
          iframe.remove();
        });
      });

      // Timeout de seguridad - si no recibimos respuesta en 5 segundos, asumir éxito
      Timer(const Duration(seconds: 5), () {
        if (!completer.isCompleted) {
          AppLogger.warning('⏱️ [$label] Timeout: asumiendo éxito (formulario enviado)');
          completer.complete();
          Timer(const Duration(milliseconds: 100), () {
            form.remove();
            iframe.remove();
          });
        }
      });

      form.submit();
      await completer.future;

      AppLogger.info('✅ [$label] Envío completado');
    } catch (e, stackTrace) {
      AppLogger.error(
        '❌ [$label] Error al enviar',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Error al enviar el formulario: $e');
    }
  }
}
