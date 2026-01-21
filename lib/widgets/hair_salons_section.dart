import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HairSalonsSection extends StatefulWidget {
  const HairSalonsSection({super.key});

  @override
  State<HairSalonsSection> createState() => _HairSalonsSectionState();
}

class _HairSalonsSectionState extends State<HairSalonsSection> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtons);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScrollButtons();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtons);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;
    final canScrollLeft = _scrollController.position.pixels > 0;
    final canScrollRight =
        _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent;

    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.pixels - 300,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.pixels + 300,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Lista de peluquerías
  final List<Map<String, String>> salons = const [
    {
      'name': 'Miriam Estilistas',
      'address': 'Calle Carreteros, 7, Toledo',
      'phone': '925 22 65 60',
      'location': 'https://www.google.com/maps/search/?api=1&query=Calle+Carreteros+7+Toledo',
    },
    {
      'name': 'Peluquería Gala',
      'address': 'Calle Real del Arrabal, 8, Toledo',
      'phone': '925 25 70 68',
      'location': 'https://www.google.com/maps/search/?api=1&query=Calle+Real+del+Arrabal+8+Toledo',
    },
    {
      'name': 'Peluqueria Europa 18',
      'address': 'Av. de Europa, 18, Toledo',
      'phone': '925 25 42 11',
      'location': 'https://www.google.com/maps/search/?api=1&query=Avenida+de+Europa+18+Toledo',
    },
    {
      'name': 'Peluquería Gallianni Milano',
      'address': 'Calle de Roma, 9, Toledo',
      'phone': '925 21 18 35',
      'location': 'https://www.google.com/maps/search/?api=1&query=Calle+de+Roma+9+Toledo',
    },
    {
      'name': 'Peluquería Nova Centro',
      'address': 'Travesía Gregorio Ramírez, 4, Toledo',
      'phone': '925 25 13 25',
      'location': 'https://www.google.com/maps/search/?api=1&query=Travesia+Gregorio+Ramirez+4+Toledo',
    },
  ];

  Future<void> _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Teléfono copiado: $text'),
            duration: const Duration(seconds: 2),
            backgroundColor: WeddingColors.successColor,
          ),
        );
      }
    } catch (e) {
      // Fallback para web usando JavaScript
      html.window.navigator.clipboard?.writeText(text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Teléfono copiado: $text'),
            duration: const Duration(seconds: 2),
            backgroundColor: WeddingColors.successColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    if (salons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: WeddingColors.backgroundLight,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            child: Text(
              'Peluquerías Recomendadas',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: WeddingColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 40),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: isMobile ? 280 : 320,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
                  clipBehavior: Clip.none,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      salons.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: index < salons.length - 1 ? 20 : 0,
                        ),
                        child: _buildSalonCard(context, salons[index], isMobile),
                      ),
                    ),
                  ),
                ),
              ),
              // Flecha izquierda
              if (_canScrollLeft)
                Positioned(
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: WeddingColors.backgroundWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: WeddingColors.burgundyPrimary,
                        size: 32,
                      ),
                      onPressed: _scrollLeft,
                      tooltip: 'Desplazar hacia la izquierda',
                    ),
                  ),
                ),
              // Flecha derecha
              if (_canScrollRight)
                Positioned(
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: WeddingColors.backgroundWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: WeddingColors.burgundyPrimary,
                        size: 32,
                      ),
                      onPressed: _scrollRight,
                      tooltip: 'Desplazar hacia la derecha',
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalonCard(
      BuildContext context, Map<String, String> salon, bool isMobile) {
    return Container(
      width: isMobile ? 280.0 : 320.0,
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.shadowColor,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre
                Text(
                  salon['name'] ?? '',
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 22,
                    fontWeight: FontWeight.w600,
                    color: WeddingColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // Dirección
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: WeddingColors.iconColor,
                      size: isMobile ? 20 : 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        salon['address'] ?? '',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 15,
                          color: WeddingColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Teléfono
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.phone,
                      color: WeddingColors.iconColor,
                      size: isMobile ? 20 : 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Teléfono',
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 13,
                              color: WeddingColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: SelectableText(
                                  salon['phone'] ?? '',
                                  style: TextStyle(
                                    fontSize: isMobile ? 16 : 17,
                                    color: WeddingColors.burgundyPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: WeddingColors.iconColor,
                                  size: isMobile ? 18 : 20,
                                ),
                                onPressed: () =>
                                    _copyToClipboard(salon['phone'] ?? ''),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Copiar teléfono',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Botón "Cómo llegar"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: salon['location'] != null &&
                            salon['location']!.isNotEmpty
                        ? () => html.window.open(salon['location']!, '_blank')
                        : null,
                    icon: Icon(
                      Icons.directions,
                      size: isMobile ? 18 : 20,
                    ),
                    label: Text(
                      'Cómo llegar',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WeddingColors.burgundyPrimary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 12 : 14,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
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
