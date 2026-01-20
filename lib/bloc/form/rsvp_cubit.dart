import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_web/bloc/form/rsvp_state.dart';
import 'package:wedding_web/models/rsvp_form.dart';
import 'package:wedding_web/repositories/rsvp_repository.dart';
import 'package:wedding_web/utils/logger.dart';

class RSVPCubit extends Cubit<RSVPState> {
  final RSVPRepository repository;

  RSVPCubit({required this.repository})
      : super(RSVPInitial(
          form: RSVPForm(name: ''),
        ));

  RSVPForm _getCurrentForm() {
    if (state is RSVPInitial) {
      return (state as RSVPInitial).form;
    } else if (state is RSVPError) {
      return (state as RSVPError).form;
    } else if (state is RSVPSubmitting) {
      return (state as RSVPSubmitting).form;
    }
    return RSVPForm(name: '');
  }

  void updateName(String name) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(name: name)));
  }

  void updateWillAttend(bool? willAttend) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(willAttend: willAttend)));
  }

  void updateHasCompanion(bool hasCompanion) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(
      form: currentForm.copyWith(
        hasCompanion: hasCompanion,
        companionNames: hasCompanion ? currentForm.companionNames : null,
      ),
    ));
  }

  void updateCompanionNames(String? companionNames) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(companionNames: companionNames)));
  }

  void updateMenuOption(String? menuOption) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(menuOption: menuOption)));
  }

  void updateBusToCelebration(String? busToCelebration) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(busToCelebration: busToCelebration)));
  }

  void updateBusReturn(String? busReturn) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(busReturn: busReturn)));
  }

  void updateStayingInToledo(bool? stayingInToledo) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(stayingInToledo: stayingInToledo)));
  }

  void updateHotelName(String? hotelName) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(hotelName: hotelName)));
  }

  void toggleAllergy(String allergy) {
    final currentForm = _getCurrentForm();
    final allergies = List<String>.from(currentForm.allergies);
    if (allergies.contains(allergy)) {
      allergies.remove(allergy);
    } else {
      allergies.add(allergy);
    }
    emit(RSVPInitial(form: currentForm.copyWith(allergies: allergies)));
  }

  void updateOtherAllergies(String? otherAllergies) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(otherAllergies: otherAllergies)));
  }


  Future<void> submitForm() async {
    final currentForm = _getCurrentForm();
    AppLogger.info('🚀 Cubit: Iniciando envío de formulario RSVP');
    AppLogger.debug('📝 Estado actual del formulario', data: currentForm.toJson());
    
    // Validación: Nombre
    if (currentForm.name.isEmpty) {
      AppLogger.warning('⚠️ Validación fallida: Nombre vacío');
      emit(RSVPError(
        message: 'El nombre es obligatorio',
        form: currentForm,
      ));
      return;
    }

    // Validación: Asistencia
    if (currentForm.willAttend == null) {
      AppLogger.warning('⚠️ Validación fallida: No se indicó si asistirá');
      emit(RSVPError(
        message: 'Por favor, indica si asistirás a la boda',
        form: currentForm,
      ));
      return;
    }

    // Si no asistirá, puede terminar aquí
    if (currentForm.willAttend == false) {
      AppLogger.info('ℹ️ Usuario no asistirá - envío simplificado');
    } else {
      AppLogger.info('✅ Usuario asistirá - validando campos adicionales');
      
      // Si asistirá, validar campos obligatorios
      if (currentForm.hasCompanion && (currentForm.companionNames == null || currentForm.companionNames!.isEmpty)) {
        AppLogger.warning('⚠️ Validación fallida: Tiene acompañante pero no se indicó nombre');
        emit(RSVPError(
          message: 'Por favor, indica el nombre de los acompañantes',
          form: currentForm,
        ));
        return;
      }
    }

    AppLogger.info('✅ Validaciones pasadas - Cambiando a estado RSVPSubmitting');
    emit(RSVPSubmitting(form: currentForm));

    try {
      AppLogger.info('📤 Cubit: Llamando al repository para enviar RSVP');
      await repository.submitRSVP(currentForm);
      AppLogger.info('✅ Cubit: RSVP enviado exitosamente - Cambiando a RSVPSuccess');
      emit(RSVPSuccess(message: '¡Gracias por confirmar tu asistencia!'));
    } catch (e, stackTrace) {
      AppLogger.error(
        '❌ Cubit: Error al enviar formulario',
        error: e,
        stackTrace: stackTrace,
      );
      emit(RSVPError(
        message: 'Error al enviar el formulario: ${e.toString()}',
        form: currentForm,
      ));
    }
  }

  void resetForm() {
    AppLogger.info('🔄 Cubit: Reseteando formulario');
    emit(RSVPInitial(form: RSVPForm(name: '')));
  }
}

