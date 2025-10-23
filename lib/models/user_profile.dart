class UserProfile {
  final int? id;
  final String fullName;
  final int age;
  final String condition; // e.g., diabetes, hypertension

  const UserProfile({this.id, required this.fullName, required this.age, required this.condition});

  UserProfile copyWith({int? id, String? fullName, int? age, String? condition}) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      condition: condition ?? this.condition,
    );
  }

  Map<String, Object?> toMap() => {
        'id': id,
        'full_name': fullName,
        'age': age,
        'condition': condition,
      };

  static UserProfile fromMap(Map<String, Object?> map) {
    return UserProfile(
      id: map['id'] as int?,
      fullName: map['full_name'] as String,
      age: map['age'] as int,
      condition: map['condition'] as String,
    );
  }
}


