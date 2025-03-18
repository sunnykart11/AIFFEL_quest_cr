// notes_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> savedQuestions = [];

  @override
  void initState() {
    super.initState();
    _loadSavedQuestions();
  }

  Future<void> _loadSavedQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedQuestionsJson = prefs.getString('saved_questions');
    if (savedQuestionsJson != null) {
      setState(() {
        savedQuestions = List<Map<String, dynamic>>.from(
          json.decode(savedQuestionsJson).map((x) => Map<String, dynamic>.from(x))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오답노트'),
        centerTitle: true,
      ),
      body: savedQuestions.isEmpty
          ? Center(
              child: Text('저장된 문제가 없습니다.'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: savedQuestions.length,
              itemBuilder: (context, index) {
                final question = savedQuestions[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () {
                      _showQuestionDialog(question);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${question['id']}번',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                question['examType'] ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            question['question'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showQuestionDialog(Map<String, dynamic> question) {
    final answer = question['answer'];
    final correctAnswer = answer == '①' ? 0 :
                         answer == '②' ? 1 :
                         answer == '③' ? 2 :
                         answer == '④' ? 3 :
                         answer == '⑤' ? 4 : -1;
    final selectedAnswer = question['selectedAnswer'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${question['id']}번 문제'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['question'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ...List.generate(5, (index) {
                final isCorrectAnswer = index == correctAnswer;
                final wasSelected = index == selectedAnswer;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCorrectAnswer ? Colors.green.withOpacity(0.2) :
                           wasSelected ? Colors.red.withOpacity(0.2) : null,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCorrectAnswer ? Colors.green :
                             wasSelected ? Colors.red : Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isCorrectAnswer ? Colors.green :
                                 wasSelected ? Colors.red : null,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question['choices'][index],
                          style: TextStyle(
                            color: isCorrectAnswer ? Colors.green :
                                   wasSelected ? Colors.red : null,
                          ),
                        ),
                      ),
                      if (isCorrectAnswer)
                        Icon(Icons.check_circle, color: Colors.green)
                      else if (wasSelected)
                        Icon(Icons.cancel, color: Colors.red),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final updatedQuestions = savedQuestions.where((q) => q['id'] != question['id']).toList();
              await prefs.setString('saved_questions', json.encode(updatedQuestions));
              setState(() {
                savedQuestions = updatedQuestions;
              });
              Navigator.pop(context);
            },
            child: Text('삭제하기', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('닫기'),
          ),
        ],
      ),
    );
  }
}