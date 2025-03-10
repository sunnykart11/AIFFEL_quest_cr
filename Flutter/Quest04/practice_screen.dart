// practice_screen.dart
import 'package:flutter/material.dart';

class PracticeScreen extends StatelessWidget {
  final List<String> topics = [
    '고1 모의고사', '고2 모의고사', '고3 모의고사', '유형별 문제 랜덤 모의고사',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('실전 문제'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                topics[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (topics[index] == '고1 모의고사') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstGrade()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class FirstGrade extends StatelessWidget {
  final List<String> topics = [
    '2024년 고1 11월 모의고사', '2024년 고1 9월 모의고사', '2024년 고1 6월 모의고사', '2024년 고1 3월 모의고사',
    '2023년 고1 11월 모의고사', '2023년 고1 9월 모의고사', '2023년 고1 6월 모의고사', '2023년 고1 3월 모의고사',
    '2022년 고1 11월 모의고사', '2022년 고1 9월 모의고사', '2022년 고1 6월 모의고사', '2022년 고1 3월 모의고사',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('고1 모의고사'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                topics[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (topics[index] == '2024년 고1 11월 모의고사') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => November24()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class November24 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2024년 고1 11월 모의고사'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('문제 화면', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}