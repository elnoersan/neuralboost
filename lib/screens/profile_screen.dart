// lib/screens/profile_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  bool _hasADHD = false;
  int _points = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (_auth.currentUser == null) return;

    final snapshot =
        await _database.child('users').child(_auth.currentUser!.uid).get();
    if (snapshot.exists) {
      setState(() {
        _hasADHD = snapshot.child('hasADHD').value as bool;
        _points = snapshot.child('points').value as int? ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email: ${_auth.currentUser?.email ?? 'N/A'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Points: $_points',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'ADHD Status: ${_hasADHD ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
