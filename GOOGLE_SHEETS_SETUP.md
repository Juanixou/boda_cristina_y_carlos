# Configuración de Google Sheets para RSVP

Esta guía te ayudará a configurar Google Sheets para almacenar automáticamente los datos del formulario RSVP.

## Paso 1: Crear una Google Sheet

1. Ve a [Google Sheets](https://sheets.google.com)
2. Crea una nueva hoja de cálculo
3. Nombra la primera hoja como "RSVP" (o el nombre que prefieras)
4. En la primera fila, añade estos encabezados:

```
A1: Timestamp
B1: Nombre
C1: Asistirá
D1: Tiene acompañante
E1: Nombres acompañantes
F1: Menú
G1: Alergias
H1: Otras alergias
I1: Autobús Catedral-Cigarral
J1: Autobús vuelta
K1: Se aloja en Toledo
L1: Nombre hotel/zona
```

## Paso 2: Crear el Google Apps Script

1. En tu Google Sheet, ve a **Extensiones** → **Apps Script**
2. Se abrirá un editor de código
3. Borra todo el código existente y pega este código:

```javascript
function doPost(e) {
  try {
    // Configurar headers CORS para evitar problemas de "failed to fetch"
    const output = ContentService.createTextOutput();
    
    // Obtener o crear la hoja de cálculo
    let sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('RSVP');
    
    // Si la hoja no existe, crearla
    if (!sheet) {
      Logger.log('Creando nueva hoja RSVP');
      sheet = SpreadsheetApp.getActiveSpreadsheet().insertSheet('RSVP');
      // Añadir encabezados
      sheet.getRange(1, 1, 1, 12).setValues([[
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
        'Nombre hotel/zona'
      ]]);
      // Formatear encabezados
      const headerRange = sheet.getRange(1, 1, 1, 12);
      headerRange.setFontWeight('bold');
      headerRange.setBackground('#722F37');
      headerRange.setFontColor('#FFFFFF');
      Logger.log('Hoja RSVP creada con encabezados');
    } else {
      Logger.log('Hoja RSVP ya existe');
    }
    
    // Verificar que tenemos la hoja
    if (!sheet) {
      throw new Error('No se pudo obtener o crear la hoja RSVP');
    }
    
    // Parsear los datos recibidos
    // Los formularios HTML envían datos en e.parameter, no en e.postData.contents
    let data;
    
    // Primero intentar obtener de parámetros (formulario HTML)
    if (e.parameter && e.parameter.data) {
      try {
        // Los datos vienen codificados como URL, necesitamos decodificarlos primero
        const decodedData = decodeURIComponent(e.parameter.data);
        data = JSON.parse(decodedData);
        Logger.log('Datos recibidos desde formulario HTML (e.parameter.data)');
      } catch (parseError) {
        // Si falla, intentar sin decodificar (por si ya viene decodificado)
        try {
          data = JSON.parse(e.parameter.data);
          Logger.log('Datos recibidos sin decodificar');
        } catch (parseError2) {
          Logger.log('Error parseando e.parameter.data: ' + parseError.toString());
          Logger.log('Valor recibido: ' + e.parameter.data.substring(0, 200));
          throw new Error('Error al parsear datos del formulario: ' + parseError.toString());
        }
      }
    } 
    // Si no está en parámetros, intentar postData (JSON directo)
    else if (e.postData && e.postData.contents) {
      try {
        data = JSON.parse(e.postData.contents);
        Logger.log('Datos recibidos desde JSON directo (e.postData.contents)');
      } catch (parseError) {
        Logger.log('Error parseando e.postData.contents: ' + parseError.toString());
        throw new Error('Error al parsear datos JSON: ' + parseError.toString());
      }
    } 
    // Si no hay datos, lanzar error
    else {
      Logger.log('No se recibieron datos. e.parameter: ' + JSON.stringify(e.parameter));
      Logger.log('e.postData: ' + (e.postData ? JSON.stringify(e.postData) : 'null'));
      throw new Error('No se recibieron datos');
    }
    
    // Log para debugging
    Logger.log('Datos parseados correctamente. Nombre: ' + (data.name || 'sin nombre'));
    
    // Preparar la fila de datos
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
      data.hotelName || ''
    ];
    
    Logger.log('Preparando fila de datos: ' + JSON.stringify(row));
    Logger.log('Nombre de la hoja: ' + sheet.getName());
    Logger.log('Número de filas antes: ' + sheet.getLastRow());
    
    // Añadir la fila a la hoja
    try {
      sheet.appendRow(row);
      Logger.log('Fila añadida exitosamente');
      Logger.log('Número de filas después: ' + sheet.getLastRow());
    } catch (appendError) {
      Logger.log('Error al añadir fila: ' + appendError.toString());
      throw new Error('Error al guardar datos en la hoja: ' + appendError.toString());
    }
    
    // Devolver respuesta exitosa con headers CORS
    return output
      .setContent(JSON.stringify({
        'status': 'success',
        'message': 'Datos guardados correctamente'
      }))
      .setMimeType(ContentService.MimeType.JSON);
      
  } catch (error) {
    // Log del error completo
    Logger.log('ERROR en doPost: ' + error.toString());
    Logger.log('Stack trace: ' + (error.stack || 'No disponible'));
    
    // Devolver error con headers CORS
    const output = ContentService.createTextOutput();
    return output
      .setContent(JSON.stringify({
        'status': 'error',
        'message': error.toString(),
        'stack': error.stack || 'No disponible'
      }))
      .setMimeType(ContentService.MimeType.JSON);
  }
}

// Función adicional para manejar CORS en preflight requests
function doOptions() {
  return ContentService.createTextOutput('')
    .setMimeType(ContentService.MimeType.JSON);
}
```

4. Guarda el proyecto con un nombre (por ejemplo, "RSVP Handler")
5. Haz clic en **Desplegar** → **Nueva implementación**
6. Selecciona:
   - **Tipo**: Aplicación web
   - **Ejecutar como**: Yo (tu cuenta de Google)
   - **Quién tiene acceso**: Cualquiera
7. Haz clic en **Desplegar**
8. **IMPORTANTE**: Copia la URL que se genera (algo como: `https://script.google.com/macros/s/...`)

## Paso 3: Configurar la URL en el código

1. Abre el archivo `lib/data/datasources/rsvp_datasource.dart`
2. Busca la línea:
   ```dart
   static const String _scriptUrl = 'TU_URL_DE_GOOGLE_APPS_SCRIPT_AQUI';
   ```
3. Reemplaza `'TU_URL_DE_GOOGLE_APPS_SCRIPT_AQUI'` con la URL que copiaste en el paso anterior
4. Asegúrate de que la URL esté entre comillas simples

## Paso 4: Autorizar el script (primera vez)

1. La primera vez que se ejecute el script, Google te pedirá autorización
2. Haz clic en **Revisar permisos**
3. Selecciona tu cuenta de Google
4. Haz clic en **Avanzado** → **Ir a [nombre del proyecto] (no seguro)**
5. Haz clic en **Permitir**

## Paso 5: Probar

1. Ejecuta tu aplicación Flutter
2. Completa el formulario RSVP
3. Envía el formulario
4. Verifica que los datos aparezcan en tu Google Sheet

## Notas importantes

- **Seguridad**: La URL del script es pública, pero solo puede escribir en tu hoja de cálculo
- **Límites**: Google Apps Script tiene límites de uso (100,000 llamadas/día para cuentas gratuitas)
- **Formato**: Los datos se guardan automáticamente con formato de fecha/hora
- **Backup**: Considera hacer copias de seguridad periódicas de tu Google Sheet

## Solución de problemas

### Error 403: No se puede acceder
- Verifica que el script esté desplegado como "Aplicación web"
- Verifica que "Quién tiene acceso" esté configurado como "Cualquiera"

### Error 404: No se encuentra
- Verifica que la URL del script sea correcta
- Asegúrate de que el script esté desplegado

### Los datos no aparecen en la hoja
- Verifica que el nombre de la hoja sea exactamente "RSVP" (o actualiza el código del script)
- Revisa los logs en Apps Script: **Ver** → **Registros de ejecución**

### Error "Failed to fetch" o problemas de CORS

Este error es común y puede tener varias causas:

1. **Actualiza el script de Google Apps Script**:
   - Asegúrate de usar el código actualizado que incluye la función `doOptions()` para manejar CORS
   - Despliega una nueva versión del script después de actualizar el código

2. **Verifica la configuración del despliegue**:
   - Ve a **Desplegar** → **Gestionar implementaciones**
   - Asegúrate de que la versión desplegada sea la más reciente
   - Verifica que "Quién tiene acceso" esté configurado como **"Cualquiera"**

3. **Prueba el script manualmente**:
   - Abre la URL del script en el navegador directamente
   - Deberías ver un mensaje de error (esto es normal, significa que el script está activo)
   - Si ves un error 404, el script no está desplegado correctamente

4. **Verifica la URL**:
   - La URL debe terminar en `/exec` (no `/dev`)
   - Asegúrate de que la URL esté completa y sin espacios

5. **Si el problema persiste**:
   - Intenta crear una nueva implementación desde cero
   - Borra la implementación anterior y crea una nueva
   - Asegúrate de que el código del script esté guardado antes de desplegar
