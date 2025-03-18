import 'package:flutter/material.dart';

class SecondGrade extends StatelessWidget {
  final List<String> topics = [
    '2024년 고2 11월 모의고사', '2024년 고2 9월 모의고사', '2024년 고2 6월 모의고사', '2024년 고2 3월 모의고사',
    '2023년 고2 11월 모의고사', '2023년 고2 9월 모의고사', '2023년 고2 6월 모의고사', '2023년 고2 3월 모의고사',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('고2 모의고사'),
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
              // onTap: () {
              //   if (topics[index] == '2024년 고2 11월 모의고사') {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => November24()),
              //     );
              //   }
              // },
            ),
          );
        },
      ),
    );
  }
}
