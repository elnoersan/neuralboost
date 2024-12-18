import 'package:flutter/material.dart';

import '../models/user.dart'; // Import the User model
import '../services/gamificate_service.dart'; // Import GamificateService
//import '../utils/level_themes.dart'; // Correct import path
//import '../utils/theme_provider.dart'; // Import ThemeProvider

class ShopScreen extends StatefulWidget {
  final User user; // Pass the User model as a parameter

  ShopScreen({required this.user});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GamificateService _gamificateService = GamificateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop & Themes Come Soon'),
      ),
      // body: ListView.builder(
      //   itemCount: LevelThemes.levelThemeMap.length,
      //   itemBuilder: (context, index) {
      //     String level = LevelThemes.levelThemeMap.keys.elementAt(index);
      //     bool isUnlocked = widget.user.unlockedThemes.contains(level);

      //     return ListTile(
      //       title: Text(level),
      //       subtitle: isUnlocked
      //           ? Text('Unlocked')
      //           : Text('Requires level: $level'), // Show required level
      //       trailing: isUnlocked
      //           ? ElevatedButton(
      //               onPressed: () {
      //                 // Apply the theme
      //                 setState(() {
      //                   Provider.of<ThemeProvider>(context, listen: false)
      //                       .setTheme(LevelThemes.levelThemeMap[level]!);
      //                 });
      //                 ScaffoldMessenger.of(context).showSnackBar(
      //                   SnackBar(content: Text('Theme applied!')),
      //                 );
      //               },
      //               child: Text('Apply'),
      //             )
      //           : ElevatedButton(
      //               onPressed: () async {
      //                 // Check if the user's level matches the required level
      //                 if (widget.user.level == level) {
      //                   // Unlock the theme
      //                   widget.user.unlockedThemes.add(level);
      //                   setState(() {}); // Refresh the UI
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     SnackBar(content: Text('Theme unlocked!')),
      //                   );
      //                 } else {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     SnackBar(
      //                         content:
      //                             Text('You must reach level $level first!')),
      //                   );
      //                 }
      //               },
      //               child: Text('Unlock'),
      //             ),
      //     );
      //   },
      // ),
    );
  }
}
