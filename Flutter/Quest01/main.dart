import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends ChangeNotifier {
  int workDuration = 25; // 25초 작업
  int shortBreakDuration = 5; // 5초 휴식
  int longBreakDuration = 15; // 15초 긴 휴식
  int cycleCount = 0; // 현재 사이클(작업+휴식) 수
  Timer? _timer;
  int remainingTime = 0;
  String status = "작업 중";

  void startPomodoro() {
    cycleCount = 0;
    _startWork();
  }

  void _startWork() {
    remainingTime = workDuration;
    status = "작업 중";
    notifyListeners();
    _startCountdown(() {
      status = "휴식 중";
      notifyListeners();
      _startBreak();
    });
  }

  void _startBreak() {
    cycleCount++;
    if (cycleCount % 4 == 0) {
      remainingTime = longBreakDuration; // 4회차는 15초 휴식
      status = "긴 휴식 중";
    } else {
      remainingTime = shortBreakDuration;
      status = "휴식 중";
    }
    notifyListeners();
    _startCountdown(() {
      status = "작업 중";
      notifyListeners();
      _startWork();
    });
  }

  void _startCountdown(Function onComplete) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime <= 0) {
        timer.cancel();
        onComplete();
      } else {
        remainingTime--;
        notifyListeners();
      }
    });
  }

  String get formattedTime {
    int minutes = remainingTime ~/ 60;
    int sec = remainingTime % 60;
    return '$minutes:${sec.toString().padLeft(2, '0')}';
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  final PomodoroTimer _pomodoroTimer = PomodoroTimer();

  @override
  void initState() {
    super.initState();
    _pomodoroTimer.startPomodoro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pomodoro Timer")),
      body: Center(
        child: AnimatedBuilder(
          animation: _pomodoroTimer,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _pomodoroTimer.status,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _pomodoroTimer.formattedTime,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}