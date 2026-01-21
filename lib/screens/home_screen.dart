import 'package:flutter/material.dart';
import 'package:wedding_web/widgets/hero_section_widget.dart';
import 'package:wedding_web/widgets/wedding_details_section.dart';
import 'package:wedding_web/widgets/hotels_section_v2.dart';
import 'package:wedding_web/widgets/hair_salons_section.dart';
import 'package:wedding_web/widgets/how_to_get_there_section.dart';
import 'package:wedding_web/widgets/wedding_list_section.dart';
import 'package:wedding_web/widgets/rsvp_form_section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Sección Hero
            HeroSectionWidget(),
            
            //const SizedBox(height: 40),
            
            // Sección de Video
            /*
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
              ),
              child: Center(
                child: VideoSectionContainer(
                  width: 700,
                  height: 480,
                  borderRadius: 16.0,
                  videoAssetPath: 'assets/video_demo.mp4',
                ),
              ),
            ),
            */
            // Sección de Detalles de la Boda
            const WeddingDetailsSection(),
            
            // Sección de Hoteles
            // const HotelsSection(),
            const HotelsSectionV2(),
            
            // Sección de Peluquerías
            const HairSalonsSection(),
            
            // Sección de Cómo llegar
            const HowToGetThereSection(),
            
            // Sección de Lista de bodas
            const WeddingListSection(),
            
            // Sección de Formulario RSVP
            const RSVPFormSection(),
          ],
        ),
      ),
    );
  }
}