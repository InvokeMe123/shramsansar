class LanguageModel {
  final String name;
  final String speaking;
  final String reading;
  final String writing;
  final String listening;

  LanguageModel(
      {required this.name,
      required this.speaking,
      required this.reading,
      required this.writing,
      required this.listening});

  Map<String, dynamic> toMap() {
    return {
      'language_name': name,
      'language_rating_speaking': speaking,
      'language_rating_reading': reading,
      'language_rating_writing': writing,
      'language_rating_listening': listening,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      name: map['language_name'],
      speaking: map['language_rating_speaking'],
      reading: map['language_rating_reading'],
      writing: map['language_rating_writing'],
      listening: map['language_rating_listening'],
    );
  }
}
