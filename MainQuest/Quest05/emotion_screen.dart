import 'package:flutter/material.dart';

class EmotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('심경 파악'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('심경 파악 화면', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class NextQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다음 문제')),
      body: Center(child: Text('여기에 다음 문제가 표시됩니다.', style: TextStyle(fontSize: 20))),
    );
  }
}
