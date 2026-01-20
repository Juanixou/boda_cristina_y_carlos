import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:wedding_web/utils/logger.dart';

abstract class RSVPDataSource {
  Future<void> submitRSVP(Map<String, dynamic> data);
}

class RSVPDataSourceImpl implements RSVPDataSource {
  // URL del Google Apps Script Web App
  // IMPORTANTE: Reemplaza esta URL con la URL de tu Google Apps Script
  // Ver instrucciones en GOOGLE_SHEETS_SETUP.md
  //ID IMPLEMENTACION: AKfycbw0eupaMpcctbEC3ko7tqfNTSSaAk9lyQ7_7JYmosflCkHbLsOs2c8wW9iGPJxghMS-EQ
  static const String _scriptUrl = 'https://script.google.com/macros/s/AKfycbwzF5WehUssHVoacMrLUh-1qdt7QUoRAbdUCToNUzJMEAvHsmxJ-U9BUiFD7VpqEfZ3OQ/exec';

  @override
  Future<void> submitRSVP(Map<String, dynamic> data) async {
    AppLogger.info('📤 Iniciando envío de RSVP', data: data);
    
    try {
      // Preparar los datos con timestamp
      final dataWithTimestamp = {
        ...data,
        'timestamp': DateTime.now().toIso8601String(),
      };

      AppLogger.debug('⏰ Datos con timestamp preparados', data: dataWithTimestamp);

      // Codificar los datos como JSON
      final jsonData = jsonEncode(dataWithTimestamp);
      AppLogger.debug('📝 JSON codificado', data: {'length': jsonData.length});
      
      AppLogger.info('🌐 Enviando petición HTTP a: $_scriptUrl');
      
      // Usar un formulario HTML oculto para evitar problemas de CORS con Google Apps Script
      // Este método es más compatible con las restricciones de CORS de Google Apps Script
      final completer = Completer<void>();
      final form = html.FormElement();
      form.method = 'POST';
      form.action = _scriptUrl;
      form.enctype = 'application/x-www-form-urlencoded'; // Formato estándar de formularios
      form.style.display = 'none';
      
      // Crear un campo oculto con los datos JSON
      // IMPORTANTE: El nombre del campo debe ser "data" para que el script lo encuentre
      final dataInput = html.InputElement(type: 'hidden');
      dataInput.name = 'data';
      // Codificar el JSON para que se envíe correctamente en el formulario
      dataInput.value = Uri.encodeComponent(jsonData);
      form.append(dataInput);
      
      AppLogger.debug('📋 Formulario creado', data: {
        'action': form.action,
        'method': form.method,
        'enctype': form.enctype,
        'dataLength': jsonData.length,
        'dataPreview': jsonData.substring(0, jsonData.length > 100 ? 100 : jsonData.length),
      });
      
      // Añadir el formulario al DOM
      html.document.body!.append(form);
      
      // Crear un iframe oculto para recibir la respuesta
      final iframe = html.IFrameElement();
      iframe.name = 'rsvp_iframe_${DateTime.now().millisecondsSinceEpoch}';
      iframe.style.display = 'none';
      form.target = iframe.name;
      html.document.body!.append(iframe);
      
      // Escuchar cuando el iframe carga (respuesta recibida)
      // Nota: No podemos leer el contenido del iframe debido a CORS,
      // pero si el iframe carga, significa que la petición se procesó
      iframe.onLoad.listen((event) {
        AppLogger.info('📥 Respuesta recibida en iframe (formulario procesado)');
        if (!completer.isCompleted) {
          completer.complete();
        }
        // Limpiar después de un breve delay
        Timer(const Duration(milliseconds: 500), () {
          form.remove();
          iframe.remove();
        });
      });
      
      // Timeout de seguridad - si no recibimos respuesta en 5 segundos, asumir éxito
      Timer(const Duration(seconds: 5), () {
        if (!completer.isCompleted) {
          AppLogger.warning('⏱️ Timeout: Asumiendo éxito (formulario enviado)');
          completer.complete();
          // Limpiar
          Timer(const Duration(milliseconds: 100), () {
            form.remove();
            iframe.remove();
          });
        }
      });
      
      // Enviar el formulario
      AppLogger.debug('📤 Enviando formulario HTML');
      form.submit();
      
      // Esperar la respuesta (o timeout)
      await completer.future;
      
      AppLogger.info('✅ RSVP enviado exitosamente');
    } catch (e, stackTrace) {
      AppLogger.error(
        '❌ Error al enviar RSVP',
        error: e,
        stackTrace: stackTrace,
      );
      // Re-lanzar la excepción para que el cubit la maneje
      throw Exception('Error al enviar el formulario: $e');
    }
  }
}

