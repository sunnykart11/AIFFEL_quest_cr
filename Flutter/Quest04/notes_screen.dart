// notes_screen.dart
import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('오답노트'), centerTitle: true,),
      body: Center(child: Text('오답노트 화면')),
    );
  }
}