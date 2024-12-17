// lib/models/user.dart
class User {
  String id;
  String email;
  int points;
  String adhdStatus; // Updated to store ADHD status as a string
  DateTime? dateResponded; // Add the dateResponded field

  User({
    required this.id,
    required this.email,
    this.points = 0,
    this.adhdStatus = 'No issue or slightly affected', // Default value
    this.dateResponded, // Default to null
  });

  // Convert User object to a Map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'points': points,
      'adhdStatus': adhdStatus,
      'dateResponded': dateResponded
          ?.toIso8601String(), // Convert DateTime to ISO 8601 string
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
          : null, // Parse the dateResponded field
    );
  }
}
