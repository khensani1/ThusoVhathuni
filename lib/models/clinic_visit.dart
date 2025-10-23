class ClinicVisit {
  final int? id;
  final DateTime date;
  final String location;
  final String reason;

  const ClinicVisit({this.id, required this.date, required this.location, required this.reason});

  Map<String, Object?> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'location': location,
        'reason': reason,
      };

  static ClinicVisit fromMap(Map<String, Object?> map) {
    return ClinicVisit(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      location: map['location'] as String,
      reason: map['reason'] as String,
    );
  }
}


