import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_web/bloc/form/rsvp_cubit.dart';
import 'package:wedding_web/bloc/form/rsvp_state.dart';
import 'package:wedding_web/models/rsvp_form.dart';
import 'package:wedding_web/repositories/rsvp_repository.dart';
import 'package:wedding_web/data/datasources/rsvp_datasource.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class RSVPFormSection extends StatelessWidget {
  const RSVPFormSection({super.key});

  final List<String> allergies = const [
    'Marisco',
    'Frutos secos',
    'Lácteos',
    'Gluten',
    'Otros',
  ];

  final List<String> menuOptions = const [
    'Menú estándar',
    'Menú vegetariano',
    'Menú vegano',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return BlocProvider(
      create: (context) => RSVPCubit(
        repository: RSVPRepository(
          dataSource: RSVPDataSourceImpl(),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 60,
          horizontal: isMobile ? 16 : 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              '¿Asistirás?',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            
            BlocConsumer<RSVPCubit, RSVPState>(
              listener: (context, state) {
                if (state is RSVPSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: WeddingColors.buttonPrimary,
                    ),
                  );
                  context.read<RSVPCubit>().resetForm();
                } else if (state is RSVPError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: WeddingColors.errorColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RSVPSubmitting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                RSVPForm form;
                if (state is RSVPInitial) {
                  form = state.form;
                } else if (state is RSVPError) {
                  form = state.form;
                } else if (state is RSVPSuccess) {
                  form = RSVPForm(name: '');
                } else {
                  form = RSVPForm(name: '');
                }
                
                return _buildForm(context, form, isMobile);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, RSVPForm form, bool isMobile) {
    final willAttend = form.willAttend;
    final showFullForm = willAttend == true;

    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
      padding: EdgeInsets.all(isMobile ? 20 : 32),
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
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Datos básicos
          _buildSectionTitle('Datos básicos', isMobile),
          const SizedBox(height: 16),
          
          // Nombre y apellidos
          TextFormField(
            initialValue: form.name,
            decoration: _inputDecoration('Nombre y apellidos *', isMobile),
            onChanged: (value) {
              context.read<RSVPCubit>().updateName(value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // ¿Asistirás a la boda?
          Text(
            '¿Asistirás a la boda?',
            style: TextStyle(
              fontSize: isMobile ? 15 : 16,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(
                label: const Text('Sí, asistiré'),
                selected: willAttend == true,
                onSelected: (selected) {
                  context.read<RSVPCubit>().updateWillAttend(selected ? true : null);
                },
                selectedColor: WeddingColors.chipSelected,
              ),
              const SizedBox(width: 16),
              ChoiceChip(
                label: const Text('No podré asistir'),
                selected: willAttend == false,
                onSelected: (selected) {
                  context.read<RSVPCubit>().updateWillAttend(selected ? false : null);
                },
                selectedColor: WeddingColors.chipSelected,
              ),
            ],
          ),

          // Si no asistirá, mostrar botón de envío y terminar
          if (willAttend == false) ...[
            const SizedBox(height: 32),
            _buildSubmitButton(context, isMobile),
          ],

          // Si asistirá, mostrar el resto del formulario
          if (showFullForm) ...[
            const SizedBox(height: 32),
            
            // Acompañantes
            _buildSectionTitle('Acompañantes', isMobile),
            const SizedBox(height: 16),
            
            Text(
              '¿Vienes acompañado?',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('SI'),
                  selected: form.hasCompanion,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateHasCompanion(selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('NO'),
                  selected: !form.hasCompanion,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateHasCompanion(!selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              ],
            ),
            
            // Nombre(s) de acompañante(s) (si aplica)
            if (form.hasCompanion) ...[
              const SizedBox(height: 24),
              TextFormField(
                initialValue: form.companionNames ?? '',
                decoration: _inputDecoration('Nombre(s) de acompañante(s) *', isMobile),
                maxLines: 2,
                onChanged: (value) {
                  context.read<RSVPCubit>().updateCompanionNames(value);
                },
              ),
            ],
            
            const SizedBox(height: 32),
            
            // Menú y alergias
            _buildSectionTitle('Menú y alergias', isMobile),
            const SizedBox(height: 16),
            
            // Opciones de menú
            Text(
              'Selecciona tu menú',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: menuOptions.map((option) {
                final isSelected = form.menuOption == option;
                return FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateMenuOption(selected ? option : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Alergias alimentarias
            Text(
              'Alergias alimentarias',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allergies.map((allergy) {
                final isSelected = form.allergies.contains(allergy);
                return FilterChip(
                  label: Text(allergy),
                  selected: isSelected,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().toggleAllergy(allergy);
                  },
                  selectedColor: WeddingColors.chipSelected,
                );
              }).toList(),
            ),
            
            // Campo de texto para "otros" alergias
            if (form.allergies.contains('Otros')) ...[
              const SizedBox(height: 24),
              TextFormField(
                initialValue: form.otherAllergies ?? '',
                maxLines: 3,
                decoration: _inputDecoration('Especifica tus alergias', isMobile),
                onChanged: (value) {
                  context.read<RSVPCubit>().updateOtherAllergies(value);
                },
              ),
            ],
            
            const SizedBox(height: 32),
            
            // Transporte
            _buildSectionTitle('Transporte', isMobile),
            const SizedBox(height: 16),
            
            // ¿Utilizarás el autobús de la Catedral al Cigarral del Ángel?
            Text(
              '¿Utilizarás el autobús de la Catedral al Cigarral del Ángel?',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Sí'),
                  selected: form.busToCelebration == 'Sí',
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateBusToCelebration(selected ? 'Sí' : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('No'),
                  selected: form.busToCelebration == 'No',
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateBusToCelebration(selected ? 'No' : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // ¿Utilizarás el autobús de vuelta a Toledo?
            Text(
              '¿Utilizarás el autobús de vuelta a Toledo?',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Sí'),
                  selected: form.busReturn == 'Sí',
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateBusReturn(selected ? 'Sí' : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
                ChoiceChip(
                  label: const Text('No'),
                  selected: form.busReturn == 'No',
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateBusReturn(selected ? 'No' : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
                ChoiceChip(
                  label: const Text('No lo sé todavía'),
                  selected: form.busReturn == 'No lo sé todavía',
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateBusReturn(selected ? 'No lo sé todavía' : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Alojamiento
            _buildSectionTitle('Alojamiento', isMobile),
            const SizedBox(height: 16),
            
            Text(
              '¿Te alojas en Toledo?',
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                fontWeight: FontWeight.w600,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Sí'),
                  selected: form.stayingInToledo == true,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateStayingInToledo(selected ? true : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('No'),
                  selected: form.stayingInToledo == false,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateStayingInToledo(selected ? false : null);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              ],
            ),
            
            // Nombre del hotel / zona (opcional)
            if (form.stayingInToledo == true) ...[
              const SizedBox(height: 24),
              TextFormField(
                initialValue: form.hotelName ?? '',
                decoration: _inputDecoration('Nombre del hotel / zona (opcional)', isMobile),
                onChanged: (value) {
                  context.read<RSVPCubit>().updateHotelName(value);
                },
              ),
            ],
            
            const SizedBox(height: 32),
            
            // Botón de envío
            _buildSubmitButton(context, isMobile),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isMobile) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isMobile ? 18 : 20,
        fontWeight: FontWeight.w600,
        color: WeddingColors.textPrimary,
      ),
    );
  }

  InputDecoration _inputDecoration(String label, bool isMobile) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: WeddingColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2, color: WeddingColors.inputFocusedBorder),
      ),
      labelStyle: TextStyle(fontSize: isMobile ? 14 : 16),
      contentPadding: EdgeInsets.all(isMobile ? 12 : 16),
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isMobile) {
    return ElevatedButton(
      onPressed: () {
        context.read<RSVPCubit>().submitForm();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: WeddingColors.buttonPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 16),
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
      child: Text(
        'Confirmar asistencia',
        style: TextStyle(
          fontSize: isMobile ? 16 : 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
