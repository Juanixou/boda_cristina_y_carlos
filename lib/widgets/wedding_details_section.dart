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
                          title: 'Ceremonia',
                          time: '12:30',
                          location: 'Catedral de Toledo',
                          address: 'Calle Cardenal Cisneros, 1, 45002 Toledo',
                          mapUrl: 'https://www.google.com/maps/search/?api=1&query=Catedral+de+Toledo',
                          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/50/Cathedral_of_Toledo_%287079311505%29.jpg',
                          applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                        ),
                        const SizedBox(height: 40),
                        _buildEventCard(
                          context,
                          title: 'Celebración',
                          time: '14:00',
                          location: 'Cigarral El Ángel',
                          address: 'Cigarral El Ángel, Toledo',
                          mapUrl: 'https://www.google.com/maps/search/?api=1&query=Cigarral+El+Angel+Toledo',
                          imageUrl: 'https://s2.abcstatics.com/media/espana/2021/07/16/cigarral-krLF--1248x698@abc.jpg',
                          applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildEventCard(
                            context,
                            title: 'Ceremonia',
                            time: '12:30',
                            location: 'Catedral de Toledo',
                            address: 'Calle Cardenal Cisneros, 1, 45002 Toledo',
                            mapUrl: 'https://www.google.com/maps/search/?api=1&query=Catedral+de+Toledo',
                            imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/50/Cathedral_of_Toledo_%287079311505%29.jpg',
                            applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
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
                            mapUrl: 'https://www.google.com/maps/search/?api=1&query=Cigarral+El+Angel+Toledo',
                            imageUrl: 'https://s2.abcstatics.com/media/espana/2021/07/16/cigarral-krLF--1248x698@abc.jpg',
                            applyBlackAndWhiteFilter: applyBlackAndWhiteFilter,
                          ),
                        ),
                      ],
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
    required String imageUrl,
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
                      0,      0,      0,      1, 0, // A
                    ]),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  )
                : Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      );
                    },
                  ),
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
                  children: [
                    Icon(Icons.access_time, color: WeddingColors.iconColor, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: WeddingColors.textPrimary,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: WeddingColors.iconColor, size: 20),
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
                
                ElevatedButton.icon(
                  onPressed: () {
                    html.window.open(mapUrl, '_blank');
                  },
                  icon: const Icon(Icons.map, size: 18),
                  label: const Text(
                    'Cómo llegar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WeddingColors.buttonPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

