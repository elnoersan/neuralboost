import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Use 'as' to rename the import
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import flutter_secure_storage
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart'; // Import the User model

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(); // Initialize secure storage

  // Key for storing the user ID token in secure storage
  static const String _userIdTokenKey = 'user_id_token';

  // Method to get the current user
  Future<User> getCurrentUser() async {
    firebase_auth.User? firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      // Check if the user ID token is stored in secure storage
      String? userIdToken = await _secureStorage.read(key: _userIdTokenKey);
      if (userIdToken != null) {
        // Try to reauthenticate the user using the stored token
        try {
          await _auth.signInWithCustomToken(userIdToken);
          firebaseUser = _auth.currentUser;
        } catch (e) {
          throw Exception('Failed to reauthenticate user');
        }
      } else {
        throw Exception('User is not authenticated');
      }
    }

    // Fetch user data from Firebase Realtime Database
    DataSnapshot snapshot =
        await _database.child('users').child(firebaseUser!.uid).get();

    if (snapshot.exists) {
      // Convert the snapshot data to a User object
      Map<String, dynamic> userData =
          Map<String, dynamic>.from(snapshot.value as Map);
      return User.fromMap(userData);
    } else {
      // Create a new User object if the user data doesn't exist
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? 'user@example.com',
        points: 0,
        adhdStatus: 'No issue or slightly affected',
      );
    }
  }

  // Method to sign in with email and password
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Save the user ID token to secure storage
      String? idToken = await _auth.currentUser?.getIdToken();
      if (idToken != null) {
        await _secureStorage.write(key: _userIdTokenKey, value: idToken);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Method to sign up with email and password
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ensure userCredential.user is not null before accessing uid
      if (userCredential.user == null) {
        throw Exception('User creation failed: User is null');
      }

      // Save user data to Firebase Realtime Database
      await _database.child('users').child(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': email,
        'points': 0,
        'adhdStatus': 'No issue or slightly affected', // Default value
        'level': 'Rookie I', // Default level
      });

      // Save the user ID token to secure storage
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _secureStorage.write(key: _userIdTokenKey, value: idToken);
      }

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

      // Ensure userCredential.user is not null before accessing uid
      if (userCredential.user == null) {
        throw Exception('Google sign-in failed: User is null');
      }

      // Save user data to Firebase Realtime Database
      await _database.child('users').child(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'points': 0,
        'adhdStatus': 'No issue or slightly affected', // Default value
        'level': 'Rookie I', // Default level
      });

      // Save the user ID token to secure storage
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        await _secureStorage.write(key: _userIdTokenKey, value: idToken);
      }

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

    // Clear the user ID token from secure storage
    await _secureStorage.delete(key: _userIdTokenKey);
  }
}
