// lib/models/user.dart
class User {
  String id;
  String email;
  int points;
  String adhdStatus; // Updated to store ADHD status as a string

  User({
    required this.id,
    required this.email,
    this.points = 0,
    this.adhdStatus = 'No issue or slightly affected', // Default value
  });
}
