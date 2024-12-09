// lib/models/user.dart
class User {
  String id;
  String email;
  int points;

  User({required this.id, required this.email, this.points = 0});
}
