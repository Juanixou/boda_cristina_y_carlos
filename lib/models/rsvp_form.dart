class RSVPForm {
  final String name;
  final bool? willAttend; // true = Sí, false = No, null = no seleccionado
  final bool hasCompanion;
  final String? companionNames; // Campo de texto para nombres de acompañantes
  final List<String> allergies;
  final String? otherAllergies;
  final String? menuOption; // Opción de menú seleccionada
  final String? busToCelebration; // "Sí", "No", null
  final String? busReturn; // "Sí", "No", "No lo sé todavía", null
  final bool? stayingInToledo; // true = Sí, false = No, null = no seleccionado
  final String? hotelName; // Nombre del hotel/zona (opcional)

  RSVPForm({
    required this.name,
    this.willAttend,
    this.hasCompanion = false,
    this.companionNames,
    this.allergies = const [],
    this.otherAllergies,
    this.menuOption,
    this.busToCelebration,
    this.busReturn,
    this.stayingInToledo,
    this.hotelName,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'willAttend': willAttend,
      'hasCompanion': hasCompanion,
      'companionNames': companionNames,
      'allergies': allergies,
      'otherAllergies': otherAllergies,
      'menuOption': menuOption,
      'busToCelebration': busToCelebration,
      'busReturn': busReturn,
      'stayingInToledo': stayingInToledo,
      'hotelName': hotelName,
    };
  }

  RSVPForm copyWith({
    String? name,
    bool? willAttend,
    bool? hasCompanion,
    String? companionNames,
    List<String>? allergies,
    String? otherAllergies,
    String? menuOption,
    String? busToCelebration,
    String? busReturn,
    bool? stayingInToledo,
    String? hotelName,
  }) {
    return RSVPForm(
      name: name ?? this.name,
      willAttend: willAttend ?? this.willAttend,
      hasCompanion: hasCompanion ?? this.hasCompanion,
      companionNames: companionNames ?? this.companionNames,
      allergies: allergies ?? this.allergies,
      otherAllergies: otherAllergies ?? this.otherAllergies,
      menuOption: menuOption ?? this.menuOption,
      busToCelebration: busToCelebration ?? this.busToCelebration,
      busReturn: busReturn ?? this.busReturn,
      stayingInToledo: stayingInToledo ?? this.stayingInToledo,
      hotelName: hotelName ?? this.hotelName,
    );
  }
}

