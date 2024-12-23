class User {
  String id;
  String email;
  int points;
  String adhdStatus;
  DateTime? dateResponded;
  String level;
  List<String> unlockedThemes; // Track unlocked themes

  User({
    required this.id,
    required this.email,
    this.points = 0,
    this.adhdStatus = 'No issue or slightly affected',
    this.dateResponded,
    this.level = 'Rookie I',
    this.unlockedThemes = const [], // Default to empty list
  });

  // Convert User object to a Map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'points': points,
      'adhdStatus': adhdStatus,
      'dateResponded': dateResponded?.toIso8601String(),
      'level': level,
      'unlockedThemes': unlockedThemes, // Include unlocked themes
    };
  }

  // Create a User object from a Map (for deserialization)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      points: map['points'],
      adhdStatus: map['adhdStatus'],
      dateResponded: map['dateResponded'] != null
          ? DateTime.parse(map['dateResponded'])
          : null,
      level: map['level'] ?? 'Rookie I',
      unlockedThemes: List<String>.from(
          map['unlockedThemes'] ?? []), // Parse unlocked themes
    );
  }
}
