// main_screen.dart
import 'package:flutter/material.dart';
import 'purpose_screen.dart';
import 'emotion_screen.dart';

class MainScreen extends StatelessWidget {
  final List<String> topics = [
    '목적 파악', '심경 파악', '주장 파악', '의미 추론', '요지 파악', '주제 추론',
    '제목 추론', '도표 분석', '내용 파악', '어법', '어휘', '빈칸 추론', '무관한 문장',
    '글의 순서', '문장 넣기', '문단 요약', '지칭 추론'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('수능 영어 유형별 학습'),
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
                if (topics[index] == '목적 파악') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PurposeScreen()),
                  );
                } else if (topics[index] == '심경 파악') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmotionScreen()),
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

