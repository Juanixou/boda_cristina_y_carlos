import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HowToGetThereSection extends StatefulWidget {
  const HowToGetThereSection({super.key});

  @override
  State<HowToGetThereSection> createState() => _HowToGetThereSectionState();
}

class _HowToGetThereSectionState extends State<HowToGetThereSection> {
  bool _parkingsExpanded = false;

  static const String _radioTaxiPhoneDisplay = '925 25 50 50';
  static const String _radioTaxiPhoneDial = '925255050';

  final String zocodoverLocation = 'https://www.google.com/maps/search/?api=1&query=Plaza+de+Zocodover+Toledo';
  final String cigarralLocation = 'https://www.google.com/maps/search/?api=1&query=Cigarral+del+Angel+Toledo';

  final List<Map<String, String>> churchParkings = const [
    {
      'name': 'Parking PARKIA by INDIGO – Miradero / Plaza de Zocodover',
      'walkingTime': 'Aproximadamente 12 minutos caminando',
      'location': 'https://www.google.com/maps/search/?api=1&query=Parking+PARKIA+Miradero+Toledo',
    },
    {
      'name': 'Parking INDIGO – Toledo Corralillo',
      'walkingTime': 'Aproximadamente 5 minutos caminando',
      'location': 'https://www.google.com/maps/search/?api=1&query=Parking+Indigo+Corralillo+Toledo',
    },
    {
      'name': 'Aparcamiento Santo Tomé S.L.',
      'walkingTime': 'Aproximadamente 4 minutos caminando',
      'location': 'https://www.google.com/maps/search/?api=1&query=Aparcamiento+Santo+Tom%C3%A9+Toledo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
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
          SizedBox(height: isMobile ? 30 : 40),

          // Tarjetas en columnas o filas según el tamaño de pantalla
          isMobile
              ? Column(
                  children: [
                    _buildCarCard(context, isMobile),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildTaxiCard(context, isMobile),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildBusToCelebrationCard(context, isMobile),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildBusReturnCard(context, isMobile),
                  ],
                )
              : Column(
                  children: [
                    // Primera fila: Coche y Taxi con misma altura
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _buildCarCard(context, isMobile)),
                          SizedBox(width: isTablet ? 16 : 20),
                          Expanded(child: _buildTaxiCard(context, isMobile)),
                        ],
                      ),
                    ),
                    SizedBox(height: isTablet ? 16 : 20),
                    // Segunda fila: Traslado y Regreso con misma altura
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _buildBusToCelebrationCard(context, isMobile)),
                          SizedBox(width: isTablet ? 16 : 20),
                          Expanded(child: _buildBusReturnCard(context, isMobile)),
                        ],
                      ),
                    ),
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
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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
                  'Si vienes en coche',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Recomendamos aparcar en alguno de los siguientes parkings públicos, todos ellos bien situados y a poca distancia a pie de la Catedral:',
            style: TextStyle(
              fontSize: isMobile ? 13 : 15,
              color: WeddingColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildParkingsExpansion(context, isMobile),
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
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                  'Si vienes en taxi',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: WeddingColors.iconColor,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'El taxi puede dejaros directamente en la Plaza del Ayuntamiento, justo enfrente de la Catedral de Toledo.',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: WeddingColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
                      'Radio Taxi Toledo',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: WeddingColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      _radioTaxiPhoneDisplay,
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
                onPressed: () => html.window.open('tel:$_radioTaxiPhoneDial', '_self'),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: 'Llamar',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusToCelebrationCard(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bus,
                color: WeddingColors.iconColor,
                size: isMobile ? 24 : 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Traslado al Cigarral del Ángel',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Tras la ceremonia, pondremos autobuses para trasladaros al Cigarral del Ángel, donde continuará la celebración.',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: WeddingColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: WeddingColors.iconColor,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salida de los autobuses:',
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 15,
                        fontWeight: FontWeight.w500,
                        color: WeddingColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => html.window.open(zocodoverLocation, '_blank'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Plaza de Zocodover',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: WeddingColors.burgundyPrimary,
                              fontWeight: FontWeight.w500,
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
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.directions_walk,
                          color: WeddingColors.iconColor,
                          size: isMobile ? 16 : 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'A unos 6 minutos a pie desde la Catedral',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 14,
                            color: WeddingColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => html.window.open(cigarralLocation, '_blank'),
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
                    Icons.celebration,
                    color: WeddingColors.iconColor,
                    size: isMobile ? 18 : 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cigarral del Ángel',
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 15,
                            fontWeight: FontWeight.w500,
                            color: WeddingColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ver ubicación en mapa',
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 13,
                            color: WeddingColors.burgundyPrimary,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.open_in_new,
                    size: isMobile ? 14 : 16,
                    color: WeddingColors.iconColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusReturnCard(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bus,
                color: WeddingColors.iconColor,
                size: isMobile ? 24 : 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Autobuses de regreso a Toledo',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: WeddingColors.iconColor,
                size: isMobile ? 20 : 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'También habrá servicio de autobuses de vuelta desde el Cigarral del Ángel a Toledo al finalizar la celebración.',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: WeddingColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.schedule,
                  color: WeddingColors.iconColor,
                  size: isMobile ? 18 : 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Las paradas y horarios están pendientes de confirmar y os los comunicaremos más adelante a través de la web.',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      color: WeddingColors.textSecondary,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
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

  Widget _buildParkingsExpansion(BuildContext context, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: WeddingColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            iconColor: WeddingColors.burgundyPrimary,
            collapsedIconColor: WeddingColors.iconColor,
            textColor: WeddingColors.textPrimary,
            collapsedTextColor: WeddingColors.textPrimary,
          ),
        ),
        child: ExpansionTile(
          initiallyExpanded: _parkingsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _parkingsExpanded = expanded;
            });
          },
          title: Row(
            children: [
              Icon(
                Icons.local_parking,
                color: WeddingColors.iconColor,
                size: isMobile ? 20 : 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ver parkings recomendados (${churchParkings.length})',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: WeddingColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                children: churchParkings.map((parking) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildParkingItem(
                        context,
                        parking['name']!,
                        parking['walkingTime']!,
                        parking['location']!,
                        isMobile,
                      ),
                    )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingItem(
    BuildContext context,
    String name,
    String walkingTime,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_walk,
                        color: WeddingColors.iconColor,
                        size: isMobile ? 14 : 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        walkingTime,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          color: WeddingColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
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

