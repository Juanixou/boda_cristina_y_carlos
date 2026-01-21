# wedding_web

Sitio web para boda desarrollado con Flutter Web.

## Despliegue en GitHub Pages

Este proyecto está configurado para desplegarse automáticamente en GitHub Pages de forma gratuita.

### Configuración inicial

1. **Habilita GitHub Pages en tu repositorio:**
   - Ve a `Settings` → `Pages` en tu repositorio de GitHub
   - En la sección **"Build and deployment"**:
     - **Source**: Selecciona `GitHub Actions` (NO selecciones "Deploy from a branch")
     - **NO necesitas configurar ningún dominio personalizado** - puedes ignorar esa sección
     - El sitio funcionará automáticamente con el dominio por defecto de GitHub
   - Guarda los cambios (si hay un botón "Save")
   
   **Nota importante:** Si ves una sección sobre "Custom domain" o "Verified domain", puedes ignorarla completamente. No es necesaria para usar GitHub Pages con el dominio gratuito de GitHub.

2. **Renombra el repositorio (importante):**
   - Para que la URL funcione correctamente, renombra tu repositorio a `boda_cristina_y_carlos`
   - Ve a `Settings` → `General` → `Repository name` en tu repositorio de GitHub
   - Cambia el nombre a `boda_cristina_y_carlos`
   - El `base-href` ya está configurado en `.github/workflows/deploy.yml` como `/boda_cristina_y_carlos/`

3. **Haz push a la rama main:**
   - El workflow se ejecutará automáticamente
   - Puedes ver el progreso en la pestaña `Actions` de tu repositorio

### URL de tu sitio

Tu sitio estará disponible en:
- `https://TU_USUARIO.github.io/boda_cristina_y_carlos/`

### Desarrollo local

Para ejecutar el proyecto localmente:

```bash
flutter pub get
flutter run -d chrome
```

Para compilar para producción:

```bash
flutter build web --release
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
