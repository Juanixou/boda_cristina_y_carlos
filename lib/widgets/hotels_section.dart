import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class HotelsSection extends StatelessWidget {
  const HotelsSection({super.key});

  /// Procesa la URL de imagen para asegurar que sea una URL directa
  /// Si es una URL de Google Images, intenta extraer la URL directa de la imagen
  static String _processImageUrl(String url) {
    // Si la URL contiene parámetros de Google Images, intentar limpiarla
    // Las URLs de Google Images a veces tienen parámetros que pueden causar problemas
    if (url.contains('googleusercontent.com') || url.contains('google.com/imgres')) {
      // Si es una URL de Google Images, intentar extraer la URL directa
      // Formato común: https://www.google.com/imgres?imgurl=URL_DIRECTA&...
      final imgUrlMatch = RegExp(r'[?&]imgurl=([^&]+)').firstMatch(url);
      if (imgUrlMatch != null) {
        return Uri.decodeComponent(imgUrlMatch.group(1)!);
      }
      
      // Si contiene googleusercontent.com, puede ser una URL directa
      if (url.contains('googleusercontent.com')) {
        // Limpiar parámetros innecesarios que puedan causar problemas
        final uri = Uri.tryParse(url);
        if (uri != null) {
          // Mantener solo los parámetros esenciales
          return uri.replace(queryParameters: {}).toString();
        }
      }
    }
    
    // Para otras URLs, devolver tal cual
    return url;
  }

  final List<Map<String, String>> hotels = const [
      {
        'name': 'Los cigarrales',
        'url': 'https://hotelcigarrales.com/',
        'image': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/167099451.jpg?k=b4269c33352cfa4c937a4554d5b27f891e0a23eed6ec6ae66cdd3d3e7bd9e65a&o=',
        'phone': '925 22 00 53',
        'discount': 'Usar código: BODACRCA10102026',
        'location': 'https://maps.app.goo.gl/5XqADttK3LMrxwoXA',
      },
    {
      'name': 'Hotel Cigarral El Bosque',
      'url': 'https://www.cigarralelbosque.com',
      'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=400',
      'phone': '925 28 56 40',
      'location': 'https://maps.google.com/?q=Cigarral+El+Bosque+Toledo',
    },
    {
      'name': 'Sercotel Renacimiento',
      'url': 'https://booking.sercotelhoteles.com/?adult=1&arrive=2026-01-01&chain=30252&child=0&currency=EUR&depart=2026-01-02&gad_campaignid=22729413543&gad_source=1&gbraid=0AAAAADxOOJ3J7Z2m7iXm1X8WfkXyUTV36&gclid=CjwKCAiA09jKBhB9EiwAgB8l-EkV_GgQpSWVkpoP1PD0UWtE-Fild_a0hm4X2occLuYPdZ35iGoNcRoC4jcQAvD_BwE&gclsrc=aw.ds&hotel=40177&level=hotel&locale=es-ES&productcurrency=EUR&rooms=1&segment=noMealPlanAssigned&src=GoogleAds&utm_campaign=ES_SEM_ES_TIER3_HOTEL_ALL_ALL_ALL_GE_NA_GOOGLE&utm_content=TOLEDO-RENACIMIENTO-RENTOL-NA&utm_medium=cpc&utm_source=GOOGLE&utm_term=sercotel%20renacimiento',
      'image': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/658827077.jpg?k=63260249480273c0fad4b7bd1c62deeb090d87cfdca7af15082f29c8e4639388&o=',
      'phone': '925 28 41 29',
      'discount': 'Realizar reserva a través de la web',
      'location': 'https://maps.app.goo.gl/f15vVVZAZnidkUFo9',
    },
    {
      'name': 'Hotel San Juan de los Reyes',
      'url': 'https://www.hotelsanjuan.com',
      'image': 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?w=400',
      'phone': '+34 925 25 31 00',
      'discount': '8% de descuento',
      'location': 'https://maps.google.com/?q=Hotel+San+Juan+de+los+Reyes+Toledo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
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
          
          SizedBox(
            height: isMobile ? 320 : 360,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < hotels.length - 1 ? 20 : 0,
                  ),
                  child: _buildHotelCard(context, hotels[index], isMobile),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context, Map<String, String> hotel, bool isMobile) {
    final cardWidth = isMobile ? 260.0 : 280.0;
    
    return GestureDetector(
      onTap: () {
        _showHotelDialog(context, hotel);
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: WeddingColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: WeddingColors.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: _buildNetworkImage(hotel['image']!),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: WeddingColors.textPrimary,
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
                      Icon(Icons.arrow_forward, size: 16, color: WeddingColors.iconColor),
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

  void _showHotelDialog(BuildContext context, Map<String, String> hotel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
                  // Header con nombre y botón cerrar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name']!,
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
                  
                  // Información del hotel
                  _buildInfoRow(
                    icon: Icons.language,
                    label: 'Sitio web',
                    value: hotel['name']!,
                    onTap: () => html.window.open(hotel['url']!, '_blank'),
                    isMobile: isMobile,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  
                  _buildInfoRow(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: hotel['phone']!,
                    onTap: () => html.window.open('tel:${hotel['phone']}', '_self'),
                    isMobile: isMobile,
                  ),
                  
                  // Mostrar descuento solo si existe y no es null
                  if (hotel['discount'] != null && hotel['discount']!.isNotEmpty) ...[
                    SizedBox(height: isMobile ? 12 : 16),
                    _buildInfoRow(
                      icon: Icons.local_offer,
                      label: 'Descuento',
                      value: hotel['discount']!,
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
    
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: WeddingColors.iconColor,
          size: isMobile ? 20 : 24,
        ),
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
              const SizedBox(height: 4),
              isSelectable
                  ? SelectableText(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: isClickable 
                            ? WeddingColors.burgundyPrimary 
                            : WeddingColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        decoration: isClickable ? TextDecoration.underline : null,
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: isClickable 
                            ? WeddingColors.burgundyPrimary 
                            : WeddingColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        decoration: isClickable ? TextDecoration.underline : null,
                      ),
                      maxLines: isMobile ? 2 : null,
                      overflow: isMobile ? TextOverflow.ellipsis : null,
                    ),
            ],
          ),
        ),
        if (isClickable)
          Icon(
            Icons.open_in_new,
            size: isMobile ? 16 : 18,
            color: WeddingColors.iconColor,
          ),
      ],
    );

    if (isClickable) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 6 : 8),
          child: content,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(isMobile ? 6 : 8),
      child: content,
    );
  }

  Widget _buildNetworkImage(String imageUrl) {
    // Procesar la URL para asegurar que sea una URL directa
    final processedUrl = _processImageUrl(imageUrl);
    
    // Para URLs de cdrst.com, usar un widget especial que maneja mejor CORS
    if (processedUrl.contains('cdrst.com')) {
      return _CdrstImageWidget(imageUrl: processedUrl);
    }
    
    // Para otras URLs, usar Image.network primero
    return Image.network(
      processedUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 180,
          color: Colors.grey.shade200,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: WeddingColors.iconColor,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Si falla, mostrar placeholder
        return Container(
          height: 180,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.hotel, size: 50, color: Colors.grey),
          ),
        );
      },
    );
  }
}

// Widget especial para cargar imágenes de cdrst.com
// Usa múltiples estrategias para evitar problemas de CORS
class _CdrstImageWidget extends StatefulWidget {
  final String imageUrl;

  const _CdrstImageWidget({required this.imageUrl});

  @override
  State<_CdrstImageWidget> createState() => _CdrstImageWidgetState();
}

class _CdrstImageWidgetState extends State<_CdrstImageWidget> {
  bool _isLoading = true;
  bool _hasError = false;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _tryLoadImage();
  }

  void _tryLoadImage() {
    // Crear un elemento img HTML para verificar si la imagen se puede cargar
    final img = html.ImageElement()
      ..src = widget.imageUrl
      ..crossOrigin = 'anonymous'; // Intentar con CORS anónimo

    img.onLoad.listen((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = false;
          _imageLoaded = true;
        });
      }
    });

    img.onError.listen((_) {
      // Si falla con CORS anónimo, intentar sin CORS
      if (mounted && !_imageLoaded) {
        final img2 = html.ImageElement()..src = widget.imageUrl;
        img2.onLoad.listen((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = false;
              _imageLoaded = true;
            });
          }
        });
        img2.onError.listen((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          }
        });
      } else if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      // Si hay error, intentar una última vez con Image.network
      return Image.network(
        widget.imageUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 180,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.hotel, size: 50, color: Colors.grey),
            ),
          );
        },
      );
    }

    if (_isLoading) {
      return Container(
        height: 180,
        color: Colors.grey.shade200,
        child: Center(
          child: CircularProgressIndicator(
            color: WeddingColors.iconColor,
          ),
        ),
      );
    }

    // Si la imagen se cargó correctamente, usar Image.network
    // El navegador ya tiene la imagen en caché, así que debería funcionar
    return Image.network(
      widget.imageUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 180,
          color: Colors.grey.shade300,
          child: const Center(
            child: Icon(Icons.hotel, size: 50, color: Colors.grey),
          ),
        );
      },
    );
  }
}

