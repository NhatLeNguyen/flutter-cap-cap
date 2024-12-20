// ship.dart
import 'package:flutter/material.dart';

class ShipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ship Screen'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text('This is the Ship Screen!'),
      ),
    );
  }
}
