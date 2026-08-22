import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class WeddingDetailsSection extends StatelessWidget {
  final bool applyBlackAndWhiteFilter;

  const WeddingDetailsSection({
    super.key,
    this.applyBlackAndWhiteFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: isMobile ? 20 : 40,
          ),
          decoration: BoxDecoration(
            color: WeddingColors.backgroundLight,
          ),
          child: Column(
            children: [
              Text(
                'Detalles de la Boda',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                  color: WeddingColors.textPrimary,
                ),
              ),
              const SizedBox(height: 50),

              // Cards lado a lado en desktop, apiladas en móvil
              isMobile
                  ? Column(
                      children: [
                        _buildEventCard(
                          context,
                          title: 'Preboda',
                          time: 'Viernes 9 de octubre de 2026 · 20:30',
                          location: 'Cigarral de Caravantes',
                          address: 'Cigarral de Caravantes, Toledo',
                          mapUrl:
                              'https://www.google.com/maps/search/?api=1&query=Cigarral+de+Caravantes+Toledo',
                          localAssetPath: 'assets/caravantes.jpeg',
                          applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                        ),
                        const SizedBox(height: 40),
                        _buildEventCard(
                          context,
                          title: 'Ceremonia',
                          time: '12:30',
                          location: 'Catedral de Toledo: Capilla de San Pedro',
                          address: 'Calle Cardenal Cisneros, 1, 45002 Toledo',
                          mapUrl:
                              'https://www.google.com/maps/search/?api=1&query=Catedral+de+Toledo',
                          localAssetPath: 'assets/catedral.jpeg',
                          applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                        ),
                        const SizedBox(height: 40),
                        _buildEventCard(
                          context,
                          title: 'Celebración',
                          time: '14:00',
                          location: 'Cigarral El Ángel',
                          address: 'Cigarral El Ángel, Toledo',
                          mapUrl:
                              'https://www.google.com/maps/search/?api=1&query=Cigarral+El+Angel+Toledo',
                          imageUrl:
                              'https://s2.abcstatics.com/media/espana/2021/07/16/cigarral-krLF--1248x698@abc.jpg',
                          applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                        ),
                      ],
                    )
                  : IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildEventCard(
                              context,
                              title: 'Preboda',
                              time: 'Viernes 9 de octubre de 2026 · 20:30',
                              location: 'Cigarral de Caravantes',
                              address: 'Cigarral de Caravantes, Toledo',
                              mapUrl:
                                  'https://www.google.com/maps/search/?api=1&query=Cigarral+de+Caravantes+Toledo',
                              localAssetPath: 'assets/caravantes.jpeg',
                              applyBlackAndWhiteFilter:
                                  applyBlackAndWhiteFilter,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: _buildEventCard(
                              context,
                              title: 'Ceremonia',
                              time: '12:30',
                              location:
                                  'Catedral de Toledo: Capilla de San Pedro',
                              address:
                                  'Calle Cardenal Cisneros, 1, 45002 Toledo',
                              mapUrl:
                                  'https://www.google.com/maps/search/?api=1&query=Catedral+de+Toledo',
                              localAssetPath: 'assets/catedral.jpeg',
                              applyBlackAndWhiteFilter:
                                  applyBlackAndWhiteFilter,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: _buildEventCard(
                              context,
                              title: 'Celebración',
                              time: '14:00',
                              location: 'Cigarral El Ángel',
                              address: 'Cigarral El Ángel, Toledo',
                              mapUrl:
                                  'https://www.google.com/maps/search/?api=1&query=Cigarral+El+Angel+Toledo',
                              imageUrl:
                                  'https://s2.abcstatics.com/media/espana/2021/07/16/cigarral-krLF--1248x698@abc.jpg',
                              applyBlackAndWhiteFilter:
                                  applyBlackAndWhiteFilter,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String time,
    required String location,
    required String address,
    required String mapUrl,
    String? imageUrl,
    String? localAssetPath,
    required bool applyBlackAndWhiteFilter,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.shadowColor,
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen con filtro blanco y negro opcional
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: applyBlackAndWhiteFilter
                ? ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.2126, 0.7152, 0.0722, 0, 0, // R
                      0.2126, 0.7152, 0.0722, 0, 0, // G
                      0.2126, 0.7152, 0.0722, 0, 0, // B
                      0, 0, 0, 1, 0, // A
                    ]),
                    child: _buildCardImage(localAssetPath, imageUrl),
                  )
                : _buildCardImage(localAssetPath, imageUrl),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                    color: WeddingColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time,
                        color: WeddingColors.iconColor, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: WeddingColors.textPrimary,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: WeddingColors.iconColor, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: WeddingColors.textPrimary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: WeddingColors.textSecondary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // La Ceremonia tiene un segundo botón (información histórica):
                // van uno a cada lado en vez de apilados, así todas las
                // tarjetas terminan con un bloque de botones de la misma
                // altura y el alto de las 3 cards queda igualado.
                title == 'Ceremonia'
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildCardButton(
                              icon: Icons.map,
                              label: 'Cómo llegar',
                              onPressed: () =>
                                  html.window.open(mapUrl, '_blank'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildCardButton(
                              icon: Icons.info_outline,
                              label: 'Información histórica',
                              onPressed: () =>
                                  _showHistoricalInfoDialog(context),
                            ),
                          ),
                        ],
                      )
                    : _buildCardButton(
                        icon: Icons.map,
                        label: 'Cómo llegar',
                        onPressed: () => html.window.open(mapUrl, '_blank'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          letterSpacing: 1,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: WeddingColors.buttonPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return WeddingColors.buttonPrimaryHover;
            }
            return null;
          },
        ),
      ),
    );
  }

  /// Foto local si se indica, si no una de red, y si no hay ninguna
  /// (como en la Preboda, que aún no tiene foto propia) un marcador
  /// decorativo en vez de una imagen rota o inventada.
  Widget _buildCardImage(String? localAssetPath, String? imageUrl) {
    if (localAssetPath != null) {
      return Image.asset(
        localAssetPath,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
      );
    }

    if (imageUrl != null) {
      return Image.network(
        imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildImageFallback(),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      color: WeddingColors.backgroundLight,
      child: Center(
        child: Icon(
          Icons.local_bar_outlined,
          size: 56,
          color: WeddingColors.iconColor,
        ),
      ),
    );
  }

  Widget _buildImageFallback() {
    return Container(
      height: 250,
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }

  void _showHistoricalInfoDialog(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: isMobile
              ? const EdgeInsets.all(20)
              : const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              maxWidth: isMobile ? double.infinity : 700,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: WeddingColors.borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: WeddingColors.shadowColor,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header con título y botón de cerrar
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: WeddingColors.borderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Información histórica',
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 26,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.5,
                          color: WeddingColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.close),
                        color: WeddingColors.textPrimary,
                        tooltip: 'Cerrar',
                      ),
                    ],
                  ),
                ),

                // Contenido scrolleable
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'La Capilla de San Pedro, ubicada en la Catedral Primada de Toledo, entre la puerta del Reloj y la de Santa Catalina, tiene una rica historia que se remonta al siglo XV. Fue fundada en 1415 por el Arzobispo de Toledo Don Sancho de Rojas, quien decidió construirla para sustituir la antigua capilla de San Pedro, que era pequeña y no cumplía con las necesidades del culto. Aunque Rojas no llegó a ver la capilla terminada antes de su muerte en 1422, sus testamentarios continuaron la obra y establecieron la parroquialidad en ella. La capilla fue el lugar de fundación de importantes cofradías y sigue siendo un lugar de gran importancia histórica y religiosa en Toledo. Fue dotada con bienes, ornamentos y alhajas por los albaceas del Arzobispo, y se convirtió en la primera parroquia de Toledo, destinada a atender a los fieles de las cuatro calles cercanas.\n\n'
                      'La capilla, situada entre la puerta del Reloj y la de Santa Catalina, es más que una capilla, es una pequeña iglesia que hace las veces de parroquia, con una portada gótica y frescos atribuidos a Pedro Berruguete. En su interior, se encuentran el túmulo funerario del fundador, el lienzo de Bayeu "La curación del paralítico" y otras pinturas de Bayeu, así como una verja de entrada del rejero Juan Francés.\n\n'
                      'La reina Isabel la Católica tuvo una relación directa con la ciudad de Toledo (construcción del Monasterio de San Juan de los Reyes) y con la Catedral en particular. La tradición cuenta que la reina Isabel la Católica utilizaba el Balcón de la Reina como un palco privado para asistir a los oficios religiosos que se celebraban en la Capilla de San Pedro.',
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 16,
                        fontWeight: FontWeight.w300,
                        height: 1.7,
                        letterSpacing: 0.5,
                        color: WeddingColors.textPrimary,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
