void startTimer() {
  if (timer != null) return;

  setState(() {
    isRunning = true; // 타이머 실행 상태로 변경
  });

  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (timeLeft > 0) {
      setState(() {
        timeLeft--; // 남은 시간 1초 감소
      });
    } else {

      timer.cancel(); // 타이머 종료
      this.timer = null; // timer 변수 초기화
      handleSessionEnd(); // 세션 종료 처리
    }
  });
}

void stopTimer() {
  if (timer != null) {
    timer!.cancel(); // 타이머 취소
    setState(() {
      isRunning = false; // 타이머가 실행되지 않는 상태로 변경
    });
  }
}

void resetTimer() {
  stopTimer(); // 타이머 일시 정지
  setState(() {
    timeLeft = workDuration; // 시간을 작업 시간으로 초기화
    cycle = 1; // 사이클을 1로 초기화
    isBreak = false; // 휴식 상태를 해제
  });
}


void startTimer() {
  // 오류 1 수정: 타이머가 이미 실행 중인 경우, 새로운 타이머가 시작되지 않도록 변경
  if (timer != null) return; // 타이머가 실행 중이면 실행하지 않음

  setState(() {
    isRunning = true; // 타이머 실행 상태로 변경
  });

  // 타이머 시작: 매 초마다 1초씩 감소
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (timeLeft > 0) {
      setState(() {
        timeLeft--; // 남은 시간 1초 감소
      });
    } else {
      // 오류 2 수정: 타이머가 종료된 후 세션을 정상적으로 전환하고 타이머 상태를 초기화
      timer.cancel(); // 타이머 종료
      this.timer = null; // 타이머 변수 초기화
      handleSessionEnd(); // 세션 종료 후 작업 및 휴식 상태 처리
    }
  });
}

void stopTimer() {
  // 오류 3 수정: 타이머가 실행 중이지 않으면 아무 작업도 하지 않도록 조건 추가
  if (timer == null) return; // 타이머가 실행 중이지 않으면 일시 정지하지 않음

  timer!.cancel(); // 타이머 취소
  setState(() {
    isRunning = false; // 타이머가 실행되지 않는 상태로 변경
  });
}

void resetTimer() {
  // 타이머가 실행 중일 때 초기화를 클릭하면 타이머가 멈추지 않는 문제 수정
  stopTimer(); // 타이머 일시 정지

  setState(() {
    timeLeft = workDuration; // 시간을 작업 시간으로 초기화
    cycle = 1; // 사이클을 1로 초기화
    isBreak = false; // 휴식 상태를 해제
  });
}

void handleSessionEnd() {
  setState(() {
    if (isBreak) {
      isBreak = false; // 휴식 후 작업 시간으로 변경
      timeLeft = workDuration; // 작업 시간으로 초기화
    } else {
      cycle++; // 사이클 증가
      isBreak = true; // 작업 후 휴식 상태로 변경
      // 4회차 후 긴 휴식, 아니면 짧은 휴식
      timeLeft = (cycle % 4 == 0) ? longBreakDuration : shortBreakDuration;
    }
  });
  startTimer(); // 타이머 다시 시작
}

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(PomodoroApp());
}

class PomodoroApp extends StatefulWidget {
  @override
  _PomodoroAppState createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State {
  static const int workDuration = 10; // 작업 시간 (10초)
  static const int shortBreakDuration = 5; // 짧은 휴식 시간 (5초)
  static const int longBreakDuration = 15; // 긴 휴식 시간 (15초, 4회차 후)

  int timeLeft = workDuration; // 남은 시간 초기값 (작업 시간)
  int cycle = 1; // 사이클 카운트 (현재 몇 번째 회차인지)
  bool isRunning = false; // 타이머가 실행 중인지 여부
  bool isBreak = false; // 현재 휴식 중인지 여부
  Timer? timer; // 타이머 변수

  // 타이머 시작 함수
  void startTimer() {
    if (timer != null) return; // 이미 타이머가 실행 중이면 실행하지 않음

    setState(() {
      isRunning = true; // 타이머 실행 상태로 변경
    });

    // 매 초마다 실행되는 타이머
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--; // 남은 시간 1초 감소
        });
      } else {
        timer.cancel(); // 타이머 종료
        this.timer = null;
        handleSessionEnd(); // 세션 종료 처리
      }
    });
  }

  // 타이머 일시 정지 함수
  void stopTimer() {
    if (timer != null) {
      timer!.cancel(); // 타이머 취소
      timer = null;
    }
    setState(() {
      isRunning = false; // 타이머가 실행되지 않는 상태로 변경
    });
  }

  // 타이머 초기화 함수
  void resetTimer() {
    stopTimer(); // 타이머 일시 정지
    setState(() {
      timeLeft = workDuration; // 시간을 작업 시간으로 초기화
      cycle = 1; // 사이클을 1로 초기화
      isBreak = false; // 휴식 상태를 해제
    });
  }

  // 세션 종료 후 작업 및 휴식 상태 전환
  void handleSessionEnd() {
    setState(() {
      if (isBreak) {
        isBreak = false; // 휴식 후 작업 시간으로 변경
        timeLeft = workDuration; // 작업 시간으로 초기화
      } else {
        cycle++; // 사이클 증가
        isBreak = true; // 작업 후 휴식 상태로 변경
        timeLeft = (cycle % 4 == 0) ? longBreakDuration : shortBreakDuration; // 4회차 후 긴 휴식
      }
    });
    startTimer(); // 타이머 시작
  }

  // 시간을 'mm:ss' 형식으로 포맷하는 함수
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60; // 분 계산
    int secs = seconds % 60; // 초 계산
    return '
    {secs.toString().padLeft(2, '0')}'; // 'mm:ss' 형식으로 반환
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Pomodoro Timer")), // 앱바 제목
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙 정렬
          children: [
            Text(
              isBreak ? "휴식 시간" : "작업 시간", // 현재 상태에 맞는 텍스트 표시
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "사이클: $cycle 회차", // 현재 사이클 표시
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              formatTime(timeLeft), // 남은 시간 표시
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 버튼을 중앙 정렬
              children: [
                ElevatedButton(
                  onPressed: isRunning ? stopTimer : startTimer, // 타이머 실행 및 일시 정지
                  child: Text(isRunning ? "일시 정지" : "시작"), // 버튼 텍스트 변경
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer, // 타이머 초기화
                  child: Text("초기화"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 회고
//
// 오류 경험
// 오류 1: 타이머가 이미 실행 중일 때 다시 시작하려는 문제 startTimer() 함수에서 timer != null을 체크하여 타이머가 실행 중일 때는 새로운 타이머가 시작되지 않도록 수정함.
//
// 오류 2: 타이머가 완료된 후 상태 변경 및 타이머 취소가 제대로 되지 않음 타이머가 종료된 후 세션이 제대로 전환되지 않는 문제가 있었고, 이를 해결하기 위해 handleSessionEnd() 함수 내에서 timer.cancel()을 추가하고, this.timer = null로 타이머를 초기화하도록 수정.
//
// 오류 3: 타이머가 실행 중일 때 초기화가 안 되는 문제 초기화 버튼을 클릭했을 때 타이머가 실행 중이라면 stopTimer()를 호출하여 타이머가 일시 정지된 후 초기화가 이루어지도록 수정.
//
// 개선된 점 오류를 수정한 후 앱이 예상대로 작동하게 됨. 타이머가 실행 중일 때만 "일시 정지" 버튼이 활성화되고, 작업 시간과 휴식 시간이 제대로 전환됨. 타이머 초기화 및 일시 정지 기능이 정상적으로 작동하며, 사이클 및 시간이 올바르게 표시됨.
//
// 혹시나 추가해 볼 수 있다면 해볼만한 추가부분.
//
// 소리 및 알림, UI 디자인 정도를 추가해볼만 하다고 생각됨.
//
// 결론 이번 프로젝트에서 다양한 오류를 경험하고 수정하는 과정을 통해 Flutter와 Dart의 상태 관리와 타이머 관련 기능을 잘 이해할 수 있었습니다. 이 경험을 바탕으로 더 다양한 코드를 짜볼 기초를 배웠다고 생각합니다.