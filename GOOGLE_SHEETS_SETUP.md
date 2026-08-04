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
M1: Preboda
```

Nota: si tu hoja "RSVP" ya existe de antes (sin la columna M), no hace falta
que la añadas a mano — el script la crea sola la primera vez que alguien
envía el RSVP tras desplegar la versión actualizada.

## Paso 2: Crear el Google Apps Script

1. En tu Google Sheet, ve a **Extensiones** → **Apps Script**
2. Se abrirá un editor de código
3. Borra todo el código existente y pega este código:

El código completo está en [`google_apps_script/Code.gs`](google_apps_script/Code.gs)
de este repositorio — cópialo entero y pégalo aquí.

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
