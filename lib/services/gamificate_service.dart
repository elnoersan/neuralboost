import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Use 'as' to rename the import
import 'package:firebase_database/firebase_database.dart';

import '../models/user.dart'; // Import your custom User model

class GamificateService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance; // Use the renamed import

  // Add points to the user's account and update their level
  Future<void> addPoints(int points) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    String userId = _auth.currentUser!.uid;
    DatabaseReference userRef = _database.child('users').child(userId);

    // Fetch the current user data
    DataSnapshot snapshot = await userRef.get();

    if (!snapshot.exists) {
      throw Exception('User data does not exist');
    }

    // Convert the snapshot data to a Map
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(snapshot.value as Map);

    // Create a User object from the Map
    User currentUser = User.fromMap(userMap); // Use your custom User model

    // Calculate points to add based on the current level
    num pointsToAdd = calculatePointsToAdd(currentUser.level, points);

    // Update the user's points
    currentUser.points += pointsToAdd.toInt();

    // Update the user's level based on the new points
    currentUser.level = calculateLevel(currentUser.points);

    // Convert the updated User object back to a Map
    Map<String, dynamic> updatedUserMap = currentUser.toMap();

    // Update the user data in the database
    await userRef.update(updatedUserMap);
  }

  // Calculate points to add based on the current level
  num calculatePointsToAdd(String currentLevel, int basePoints) {
    switch (currentLevel) {
      case 'Rookie I':
      case 'Rookie II':
      case 'Rookie III':
        return basePoints; // 10 points for Rookie
      case 'Senior I':
      case 'Senior II':
      case 'Senior III':
        return basePoints * 2.5; // 25 points for Senior
      case 'Master I':
      case 'Master II':
      case 'Master III':
        return basePoints * 5; // 50 points for Master
      case 'Mind Focus':
        return basePoints * 10; // Infinite points for Mind Focus
      default:
        return basePoints;
    }
  }

  // Calculate the user's level based on their points
  String calculateLevel(int points) {
    if (points < 200) {
      return 'Rookie I';
    } else if (points < 400) {
      return 'Rookie II';
    } else if (points < 600) {
      return 'Rookie III';
    } else if (points < 900) {
      return 'Senior I';
    } else if (points < 1200) {
      return 'Senior II';
    } else if (points < 1500) {
      return 'Senior III';
    } else if (points < 2000) {
      return 'Master I';
    } else if (points < 2500) {
      return 'Master II';
    } else if (points < 3000) {
      return 'Master III';
    } else {
      return 'Mind Focus'; // Infinite progression
    }
  }
}
