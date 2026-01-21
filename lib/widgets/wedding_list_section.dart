import 'package:flutter/material.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class WeddingListSection extends StatelessWidget {
  const WeddingListSection({super.key});

  final String donationText =
      'El mejor regalo es compartir este día con vosotros. Si aun así queréis tener un detalle, hemos habilitado una cuenta para ayudarnos con la luna de miel.';
  final String accountNumber = 'ES12 0128 8700 1201 0585 0142'; // Número de cuenta de ejemplo

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
        color: WeddingColors.backgroundLight,
      ),
      child: Column(
        children: [
          Text(
            'Lista de bodas',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 40),

          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 600,
            ),
            decoration: BoxDecoration(
              color: WeddingColors.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: WeddingColors.borderColor,
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(isMobile ? 24 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icono y título
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: WeddingColors.iconColor,
                      size: isMobile ? 28 : 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Contribución al viaje de bodas',
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

                // Texto de donación
                Text(
                  donationText,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 17,
                    color: WeddingColors.textPrimary,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Número de cuenta
                Container(
                  padding: EdgeInsets.all(isMobile ? 16 : 20),
                  decoration: BoxDecoration(
                    color: WeddingColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: WeddingColors.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: WeddingColors.iconColor,
                            size: isMobile ? 20 : 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Número de cuenta',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 15,
                              color: WeddingColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SelectableText(
                        accountNumber,
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 22,
                          color: WeddingColors.burgundyPrimary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Haz clic para seleccionar y copiar',
                        style: TextStyle(
                          fontSize: isMobile ? 11 : 12,
                          color: WeddingColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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

