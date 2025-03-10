// stats_screen.dart
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('나의 성적'), centerTitle: true,),
      body: Center(child: Text('성적표 화면')),
    );
  }
}