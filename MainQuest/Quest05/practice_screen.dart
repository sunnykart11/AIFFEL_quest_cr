// practice_screen.dart
import 'package:flutter/material.dart';
import 'first_grade.dart';
import 'second_grade.dart';
import 'third_grade.dart';

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
                };
                if (topics[index] == '고2 모의고사') {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondGrade()),
                );
                };
                if (topics[index] == '고3 모의고사') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdGrade()),
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

