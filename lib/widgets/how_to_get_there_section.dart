import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HowToGetThereSection extends StatelessWidget {
  const HowToGetThereSection({super.key});

  final List<Map<String, String>> churchParkings = const [
    {
      'name': 'Parking 1 - Iglesia',
      'location': 'https://maps.app.goo.gl/ejemplo1',
    },
    {
      'name': 'Parking 2 - Iglesia',
      'location': 'https://maps.app.goo.gl/ejemplo2',
    },
  ];

  final Map<String, String> celebrationParking = const {
    'name': 'Parking - Lugar de celebración',
    'location': 'https://maps.app.goo.gl/ejemplo3',
  };

  final String taxiPhone = '925 XX XX XX';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 20,
      ),
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
      ),
      child: Column(
        children: [
          Text(
            'Cómo llegar',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 40),

          // Tarjetas en columnas o filas según el tamaño de pantalla
          isMobile
              ? Column(
                  children: [
                    _buildCarCard(context, isMobile),
                    const SizedBox(height: 20),
                    _buildTaxiCard(context, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildCarCard(context, isMobile)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildTaxiCard(context, isMobile)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildCarCard(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_car,
                color: WeddingColors.iconColor,
                size: isMobile ? 24 : 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Para los que váis en coche',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Parkings para la iglesia
          Text(
            'Parkings para la iglesia',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...churchParkings.map((parking) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildParkingItem(
                  context,
                  parking['name']!,
                  parking['location']!,
                  isMobile,
                ),
              )),

          const SizedBox(height: 20),

          // Parking del lugar de celebración
          Text(
            'Parking del lugar de celebración',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildParkingItem(
            context,
            celebrationParking['name']!,
            celebrationParking['location']!,
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxiCard(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_taxi,
                color: WeddingColors.iconColor,
                size: isMobile ? 24 : 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Para los que os quedáis en Toledo',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.phone,
                color: WeddingColors.iconColor,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teléfono de contacto',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: WeddingColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      taxiPhone,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: WeddingColors.burgundyPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.phone,
                  color: WeddingColors.iconColor,
                  size: isMobile ? 20 : 24,
                ),
                onPressed: () => html.window.open('tel:$taxiPhone', '_self'),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParkingItem(
    BuildContext context,
    String name,
    String location,
    bool isMobile,
  ) {
    return InkWell(
      onTap: () => html.window.open(location, '_blank'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: WeddingColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: WeddingColors.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.local_parking,
              color: WeddingColors.iconColor,
              size: isMobile ? 20 : 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: WeddingColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Ver en mapa',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          color: WeddingColors.burgundyPrimary,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.open_in_new,
                        size: isMobile ? 14 : 16,
                        color: WeddingColors.iconColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

