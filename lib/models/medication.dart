class Medication {
  final int? id;
  final String name;
  final String dosage; // e.g., 500mg
  final String frequency; // e.g., 2x daily

  const Medication({this.id, required this.name, required this.dosage, required this.frequency});

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'dosage': dosage,
        'frequency': frequency,
      };

  static Medication fromMap(Map<String, Object?> map) {
    return Medication(
      id: map['id'] as int?,
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
    );
  }
}


