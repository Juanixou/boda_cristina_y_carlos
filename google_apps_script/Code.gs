/**
 * Google Apps Script Web App para el RSVP de la web de la boda.
 * Guarda cada envío como una fila nueva en la pestaña "RSVP", incluyendo
 * la pregunta de la preboda (columna "Preboda", al final para no
 * desalinear las respuestas que ya estaban guardadas antes de añadirla).
 *
 * IMPORTANTE: al actualizar el script en un proyecto ya desplegado, usa
 * "Desplegar" -> "Gestionar implementaciones" -> lápiz de editar -> "Nueva
 * versión", para conservar la MISMA URL /exec que ya usa la web en producción.
 */

function doPost(e) {
  try {
    const output = ContentService.createTextOutput();

    let sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('RSVP');

    if (!sheet) {
      sheet = SpreadsheetApp.getActiveSpreadsheet().insertSheet('RSVP');
      sheet.getRange(1, 1, 1, 13).setValues([[
        'Timestamp',
        'Nombre',
        'Asistirá',
        'Tiene acompañante',
        'Nombres acompañantes',
        'Menú',
        'Alergias',
        'Otras alergias',
        'Autobús Catedral-Cigarral',
        'Autobús vuelta',
        'Se aloja en Toledo',
        'Nombre hotel/zona',
        'Preboda',
      ]]);
      const headerRange = sheet.getRange(1, 1, 1, 13);
      headerRange.setFontWeight('bold');
      headerRange.setBackground('#722F37');
      headerRange.setFontColor('#FFFFFF');
    } else {
      // La hoja RSVP ya existía de antes de incorporar la pregunta de la
      // preboda: añadimos la cabecera nueva AL FINAL (columna M) para no
      // desalinear las respuestas que ya estaban guardadas.
      const headerCell = sheet.getRange(1, 13);
      if (headerCell.getValue() !== 'Preboda') {
        headerCell.setValue('Preboda');
        headerCell.setFontWeight('bold');
        headerCell.setBackground('#722F37');
        headerCell.setFontColor('#FFFFFF');
      }
    }

    // Los formularios HTML envían datos en e.parameter, no en e.postData.contents
    let data;

    if (e.parameter && e.parameter.data) {
      try {
        const decodedData = decodeURIComponent(e.parameter.data);
        data = JSON.parse(decodedData);
        Logger.log('Datos recibidos desde formulario HTML (e.parameter.data)');
      } catch (parseError) {
        try {
          data = JSON.parse(e.parameter.data);
          Logger.log('Datos recibidos sin decodificar');
        } catch (parseError2) {
          Logger.log('Error parseando e.parameter.data: ' + parseError.toString());
          Logger.log('Valor recibido: ' + e.parameter.data.substring(0, 200));
          throw new Error('Error al parsear datos del formulario: ' + parseError.toString());
        }
      }
    } else if (e.postData && e.postData.contents) {
      try {
        data = JSON.parse(e.postData.contents);
        Logger.log('Datos recibidos desde JSON directo (e.postData.contents)');
      } catch (parseError) {
        Logger.log('Error parseando e.postData.contents: ' + parseError.toString());
        throw new Error('Error al parsear datos JSON: ' + parseError.toString());
      }
    } else {
      Logger.log('No se recibieron datos. e.parameter: ' + JSON.stringify(e.parameter));
      Logger.log('e.postData: ' + (e.postData ? JSON.stringify(e.postData) : 'null'));
      throw new Error('No se recibieron datos');
    }

    Logger.log('Datos parseados correctamente. Nombre: ' + (data.name || 'sin nombre'));

    const row = [
      data.timestamp || new Date().toISOString(),
      data.name || '',
      data.willAttend === true ? 'Sí' : data.willAttend === false ? 'No' : '',
      data.hasCompanion ? 'Sí' : 'No',
      data.companionNames || '',
      data.menuOption || '',
      data.allergies ? data.allergies.join(', ') : '',
      data.otherAllergies || '',
      data.busToCelebration || '',
      data.busReturn || '',
      data.stayingInToledo === true ? 'Sí' : data.stayingInToledo === false ? 'No' : '',
      data.hotelName || '',
      data.attendsPreboda === true ? 'Sí' : data.attendsPreboda === false ? 'No' : '',
    ];

    sheet.appendRow(row);

    return output
      .setContent(JSON.stringify({
        'status': 'success',
        'message': 'Datos guardados correctamente'
      }))
      .setMimeType(ContentService.MimeType.JSON);

  } catch (error) {
    Logger.log('ERROR en doPost: ' + error.toString());
    const output = ContentService.createTextOutput();
    return output
      .setContent(JSON.stringify({
        'status': 'error',
        'message': error.toString()
      }))
      .setMimeType(ContentService.MimeType.JSON);
  }
}

// Función adicional para manejar CORS en preflight requests
function doOptions() {
  return ContentService.createTextOutput('')
    .setMimeType(ContentService.MimeType.JSON);
}
