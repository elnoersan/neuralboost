// lib/models/user.dart
class User {
  String id;
  String email;
  int points;
  bool hasADHD; // New field to store ADHD status

  User({
    required this.id,
    required this.email,
    this.points = 0,
    this.hasADHD = false, // Default value is false
  });
}
