// lib/screens/shop_screen.dart
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Center(
        child: Text('Purchase themes and other items here'),
      ),
    );
  }
}
