import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';



List<Map<String, dynamic>> finalQuestions = [];
final AudioPlayer audioPlayer = AudioPlayer();

Future<void> loadQuestions() async {
  try {
    final String jsonString = await rootBundle.loadString('assets/final_questions.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    finalQuestions = jsonList.map((json) => Map<String, dynamic>.from(json)).toList();
    print('문제 데이터 로드 완료: ${finalQuestions.length}개');
  } catch (e) {
    print('문제 데이터 로드 실패: $e');
  }
}

class November24 extends StatefulWidget {
  @override
  _November24State createState() => _November24State();
}

class _November24State extends State<November24> {
  int currentQuestionIndex = 0;
  List<int> selectedAnswers = List.filled(7, -1);
  bool isGrading = false;
  bool isLoading = true;
  String errorMessage = '';
  Timer? _timer;
  int _timeLeft = 30; // 70초
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  void _startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _isTimerRunning = false;
          _playAlarmAndSwitchScreen();
        }
      });
    });
  }

  Future<void> _playAlarmAndSwitchScreen() async {
    try {
      print('알람 소리 재생 시도');
      await audioPlayer.setSource(AssetSource('alarm.mp3'));
      await audioPlayer.resume();

      // 3초 동안 대기
      await Future.delayed(Duration(seconds: 3));

      // 알람 소리 중지
      await audioPlayer.stop();
      print('알람 소리 재생 완료');

      // 화면 전환
      setState(() {
        isGrading = true;
      });
    } catch (e) {
      print('알람 소리 재생 실패: $e');
      // 에러가 발생해도 화면은 전환
      setState(() {
        isGrading = true;
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _loadQuestions() async {
    try {
      await loadQuestions();
      if (finalQuestions.isEmpty) {
        setState(() {
          errorMessage = '문제 데이터를 불러올 수 없습니다.';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = '문제 데이터를 불러오는 중 오류가 발생했습니다.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2024년 고1 11월 모의고사'),
        centerTitle: true,
        actions: [
          if (!isGrading && !isLoading && errorMessage.isEmpty)
            TextButton(
              onPressed: () {
                if (selectedAnswers.every((answer) => answer != -1)) {
                  setState(() {
                    isGrading = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('모든 문제를 풀어주세요.')),
                  );
                }
              },
              child: Text('채점하기', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : isGrading
          ? _buildGradingView()
          : Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  _formatTime(_timeLeft),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildQuestionView(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(finalQuestions.length, (questionIndex) {
            final question = finalQuestions[questionIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${question['id']}번',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  question['question'],
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                ...List.generate(5, (index) {
                  final isSelected = selectedAnswers[questionIndex] == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnswers[questionIndex] = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text('${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Expanded(child: Text(
                            question['choices'][index],
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.red : Colors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGradingView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '채점 결과',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...List.generate(7, (index) {
            final question = finalQuestions[index];
            final selectedAnswer = selectedAnswers[index];
            final answer = question['answer'];
            final correctAnswer = answer == '①' ? 0 :
            answer == '②' ? 1 :
            answer == '③' ? 2 :
            answer == '④' ? 3 :
            answer == '⑤' ? 4 : -1;
            final isCorrect = selectedAnswer == correctAnswer;

            return GestureDetector(
              onTap: () {
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
                          ...List.generate(5, (choiceIndex) {
                            final isCorrectAnswer = choiceIndex == correctAnswer;
                            final wasSelected = choiceIndex == selectedAnswer;
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isCorrectAnswer ? Colors.green.withOpacity(0.2) :
                                       wasSelected && !isCorrect ? Colors.red.withOpacity(0.2) : null,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isCorrectAnswer ? Colors.green :
                                         wasSelected && !isCorrect ? Colors.red : Colors.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${choiceIndex + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCorrectAnswer ? Colors.green :
                                             wasSelected && !isCorrect ? Colors.red : null,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      question['choices'][choiceIndex],
                                      style: TextStyle(
                                        color: isCorrectAnswer ? Colors.green :
                                               wasSelected && !isCorrect ? Colors.red : null,
                                      ),
                                    ),
                                  ),
                                  if (isCorrectAnswer)
                                    Icon(Icons.check_circle, color: Colors.green)
                                  else if (wasSelected && !isCorrect)
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
                          final String? savedQuestionsJson = prefs.getString('saved_questions');
                          List<Map<String, dynamic>> savedQuestions = [];
                          
                          if (savedQuestionsJson != null) {
                            savedQuestions = List<Map<String, dynamic>>.from(
                              json.decode(savedQuestionsJson).map((x) => Map<String, dynamic>.from(x))
                            );
                          }

                          // 이미 저장된 문제인지 확인
                          final bool isAlreadySaved = savedQuestions.any((q) => q['id'] == question['id']);
                          
                          if (!isAlreadySaved) {
                            // 문제 정보에 시험 유형 추가
                            final Map<String, dynamic> questionToSave = {
                              ...question,
                              'selectedAnswer': selectedAnswer,
                              'examType': '2024년 고1 11월 모의고사'
                            };
                            
                            savedQuestions.add(questionToSave);
                            await prefs.setString('saved_questions', json.encode(savedQuestions));
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('문제가 저장되었습니다.')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('이미 저장된 문제입니다.')),
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: Text('저장하기'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('닫기'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text('${question['id']}번: ${isCorrect ? '정답' : '오답'}'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isGrading = false;
                selectedAnswers = List.filled(7, -1);
                currentQuestionIndex = 0;
                _timeLeft = 30;
                _startTimer();
              });
            },
            child: Text('다시 풀기'),
          ),
        ],
      ),
    );
  }
}