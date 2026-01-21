import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

/// V2: tarjetas sin imágenes, mostrando la información "extendida" directamente en la card.
/// Mantiene el diálogo al pulsar (para ver todo con más aire en móvil/desktop).
class HotelsSectionV2 extends StatefulWidget {
  const HotelsSectionV2({super.key});

  @override
  State<HotelsSectionV2> createState() => _HotelsSectionV2State();
}

class _HotelsSectionV2State extends State<HotelsSectionV2> {
  late final ScrollController _scrollController;
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollButtons);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollButtons());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtons);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final canScrollLeft = position.pixels > 0;
    final canScrollRight = position.pixels < position.maxScrollExtent;
    if (canScrollLeft != _canScrollLeft || canScrollRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canScrollLeft;
        _canScrollRight = canScrollRight;
      });
    }
  }

  void _scrollLeft() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.offset - 320,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.offset + 320,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, String>> hotels = const [
    {
      'name': 'Hotel Sol',
      'url': 'https://hotelyhostalsol.com/',
      'phone': '925 21 36 50',
      'discount': 'Llamar por teléfono y decir Boda Carlos y Cristina',
      'location': 'https://maps.app.goo.gl/wtdanRcY6GAZkfZu5',
    },
    {
      'name': 'Hostal Sol',
      'url': 'https://hotelyhostalsol.com/',
      'phone': '925 21 36 50',
      'discount': 'Llamar por teléfono y decir Boda Carlos y Cristina',
      'location': 'https://maps.app.goo.gl/wtdanRcY6GAZkfZu5',
    },
    {
      'name': 'Los Cigarrales',
      'url': 'https://hotelcigarrales.com/',
      'phone': '925 22 00 53',
      'discount': 'BODACRCA10102026',
      'location': 'https://maps.app.goo.gl/DmE2QdaScTXgkoHj7',
    },
    {
      'name': 'Eurostars Toledo 4*',
      'url':
          'https://www.eurostarshotels.com/eurostars-toledo.html?referer_code=lb0gg00yx&utm_source=google&utm_medium=business&utm_campaign=lb0gg00yx',
      'phone': '925 28 23 73',
      'discount': '',
      'location': 'https://maps.app.goo.gl/25DSEfLXcoZ34RuL6',
    },
    {
      'name': 'Sercotel Renacimiento',
      'url':
          'https://www.sercotelhoteles.com/es/hotel-toledo-renacimiento?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/Zw2gYQ96bAqBXLTD8',
    },
    {
      'name': 'Sercotel Toledo Imperial',
      'url':
          'https://www.sercotelhoteles.com/es/hotel-toledo-imperial?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/6Zf6xrcrriCfeaZr6',
    },
    {
      'name': 'Sercotel Alfonso VI',
      'url':
          'https://www.sercotelhoteles.com/es/hotel-alfonso-vi?utm_source=google&utm_medium=referral&utm_campaign=metasearch-links',
      'phone': '925 28 41 29',
      'discount': 'Realizar a través de la web',
      'location': 'https://maps.app.goo.gl/BGBZiwddvAsEsL3p9',
    },
    {
      'name': 'AC Hotel',
      'url':
          'https://www.marriott.com/en-us/hotels/madto-ac-hotel-ciudad-de-toledo/overview/?scid=f2ae0541-1279-4f24-b197-a979c79310b0',
      'phone': '925 28 51 25',
      'discount': '',
      'location': 'https://maps.app.goo.gl/u6HnGqpyHVYnw9ks6',
    },
    {
      'name': 'Hotel Abad',
      'url': 'https://www.hotelabad.com/es/',
      'phone': '925 28 35 00',
      'discount': '',
      'location': 'https://maps.app.goo.gl/HFEGtyB5X8Kffy4YA',
    },
    {
      'name': 'Hotel Beatriz',
      'url':
          'https://www.beatrizhoteles.com/es/hotel-beatriz-toledo-auditorium-spa-en-toledo/?partner=5119',
      'phone': '925 26 91 00',
      'discount': '',
      'location': 'https://maps.app.goo.gl/Rz3qGDgppxqb7xPR6',
    },
    {
      'name': 'El Bosque',
      'url': 'https://www.hotelcigarralelbosque.com/',
      'phone': '925 28 56 40',
      'discount': '',
      'location': 'https://maps.app.goo.gl/x76con9vkX7CtaR87',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(color: WeddingColors.backgroundLight),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            child: Text(
              'Hoteles Recomendados',
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
            children: [
              SizedBox(
                height: isMobile ? 340 : 360,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
                  clipBehavior: Clip.none,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      hotels.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          right: index < hotels.length - 1 ? 20 : 0,
                        ),
                        child: _buildHotelCard(context, hotels[index], isMobile),
                      ),
                    ),
                  ),
                ),
              ),
              if (_canScrollLeft)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
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
                ),
              if (_canScrollRight)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
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
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(
    BuildContext context,
    Map<String, String> hotel,
    bool isMobile,
  ) {
    final cardWidth = isMobile ? 300.0 : 340.0;

    return _DraggableCard(
      onTap: () => _showHotelDialog(context, hotel),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: WeddingColors.backgroundWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: WeddingColors.borderColor, width: 1),
          ),
          padding: EdgeInsets.all(isMobile ? 16 : 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.hotel, color: WeddingColors.iconColor, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      hotel['name'] ?? '',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.w600,
                        color: WeddingColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                icon: Icons.language,
                label: 'Sitio web',
                value: 'Abrir web',
                onTap: () => html.window.open(hotel['url']!, '_blank'),
                isMobile: isMobile,
              ),
              const SizedBox(height: 10),
              _buildInfoRow(
                icon: Icons.phone,
                label: 'Teléfono',
                value: hotel['phone'] ?? '',
                onTap: () => html.window.open('tel:${hotel['phone']}', '_self'),
                isMobile: isMobile,
                isSelectable: true,
              ),
              if ((hotel['discount'] ?? '').isNotEmpty) ...[
                const SizedBox(height: 10),
                _buildInfoRow(
                  icon: Icons.local_offer,
                  label: 'Descuento',
                  value: hotel['discount'] ?? '',
                  onTap: null,
                  isMobile: isMobile,
                  isSelectable: true,
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => html.window.open(hotel['location']!, '_blank'),
                  icon: const Icon(Icons.directions),
                  label: const Text('Cómo llegar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WeddingColors.burgundyPrimary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Ver más',
                    style: TextStyle(
                      color: WeddingColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: WeddingColors.iconColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHotelDialog(BuildContext context, Map<String, String> hotel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 16 : 24,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 500,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name'] ?? '',
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w600,
                            color: WeddingColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: WeddingColors.iconColor),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 20 : 24),
                  _buildInfoRow(
                    icon: Icons.language,
                    label: 'Sitio web',
                    value: hotel['name'] ?? '',
                    onTap: () => html.window.open(hotel['url']!, '_blank'),
                    isMobile: isMobile,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: hotel['phone'] ?? '',
                    onTap: () => html.window.open('tel:${hotel['phone']}', '_self'),
                    isMobile: isMobile,
                  ),
                  if ((hotel['discount'] ?? '').isNotEmpty) ...[
                    SizedBox(height: isMobile ? 12 : 16),
                    _buildInfoRow(
                      icon: Icons.local_offer,
                      label: 'Descuento',
                      value: hotel['discount'] ?? '',
                      onTap: null,
                      isMobile: isMobile,
                      isSelectable: true,
                    ),
                  ],
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildInfoRow(
                    icon: Icons.location_on,
                    label: 'Ubicación',
                    value: 'Ver en mapa',
                    onTap: () => html.window.open(hotel['location']!, '_blank'),
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback? onTap,
    bool isMobile = false,
    bool isSelectable = false,
  }) {
    final isClickable = onTap != null;

    final Widget valueWidget = isSelectable
        ? SelectableText(
            value,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: isClickable ? WeddingColors.burgundyPrimary : WeddingColors.textPrimary,
              fontWeight: FontWeight.w500,
              decoration: isClickable ? TextDecoration.underline : null,
            ),
          )
        : Text(
            value,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: isClickable ? WeddingColors.burgundyPrimary : WeddingColors.textPrimary,
              fontWeight: FontWeight.w500,
              decoration: isClickable ? TextDecoration.underline : null,
            ),
            maxLines: isMobile ? 2 : null,
            overflow: isMobile ? TextOverflow.ellipsis : null,
          );

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: WeddingColors.iconColor, size: isMobile ? 20 : 22),
        SizedBox(width: isMobile ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 12,
                  color: WeddingColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 3),
              valueWidget,
            ],
          ),
        ),
        if (isClickable)
          Icon(Icons.open_in_new, size: isMobile ? 16 : 18, color: WeddingColors.iconColor),
      ],
    );

    if (!isClickable) {
      return Padding(
        padding: EdgeInsets.all(isMobile ? 4 : 6),
        child: content,
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 4 : 6),
        child: content,
      ),
    );
  }
}

class _DraggableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _DraggableCard({required this.child, required this.onTap});

  @override
  State<_DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<_DraggableCard> {
  Offset? _pointerDownPosition;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _pointerDownPosition = event.position;
        _isDragging = false;
      },
      onPointerMove: (event) {
        if (_pointerDownPosition == null) return;
        final delta = event.position - _pointerDownPosition!;
        if (delta.dx.abs() > 10 || delta.dy.abs() > 10) {
          _isDragging = true;
        }
      },
      onPointerUp: (event) {
        if (!_isDragging && _pointerDownPosition != null) {
          widget.onTap();
        }
        _pointerDownPosition = null;
        _isDragging = false;
      },
      child: widget.child,
    );
  }
}

