// lib/services/auth_service.dart
// TODO BETTER AUTH SERVICE MAKE IT PERMANENT OR EXPIRY
import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Use 'as' prefix for Firebase Auth
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neuralboost/models/user.dart'; // Import your custom User model

class AuthService {
  final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance; // Use the prefixed FirebaseAuth
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Method to get the current user
  Future<User> getCurrentUser() async {
    firebase_auth.User? firebaseUser =
        _auth.currentUser; // Get the Firebase User

    if (firebaseUser == null) {
      throw Exception('User is not authenticated');
    }

    // Fetch user data from Firebase Realtime Database
    DataSnapshot snapshot =
        await _database.child('users').child(firebaseUser.uid).get();

    if (snapshot.exists) {
      // Explicitly cast the data to Map<String, dynamic>
      Map<String, dynamic> userData =
          Map<String, dynamic>.from(snapshot.value as Map);

      return User(
        id: userData['id'],
        email: userData['email'],
        points: userData['points'],
        hasADHD: userData['hasADHD'],
      );
    } else {
      // If user data doesn't exist, return a default user object
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? 'user@example.com',
        points: 0,
        hasADHD: false,
      );
    }
  }

  // Method to sign in with email and password
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Method to sign up with email and password
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user data to Firebase Realtime Database
      await _database.child('users').child(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': email,
        'points': 0,
        'hasADHD': false,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Method to sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      firebase_auth.UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user data to Firebase Realtime Database
      await _database.child('users').child(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'points': 0,
        'hasADHD': false,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Method to check if a user is logged in
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  // Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
