# 수능 영어 공략 앱 설계하기
## 앱 정보
### 
- 앱 이름 : '수능 영어 공략'  
- 타겟 : 수능 영어를 대비하여 학습 중인 초,중,고등학생
## 앱 구조도
![image](https://github.com/user-attachments/assets/25169256-2b42-41e5-bcfc-563db42900ba)
## 앱 와이어프레임 (사용 툴: 파워포인트)
![image](https://github.com/user-attachments/assets/04784989-d787-4409-9bcf-2003aac88846)
![image](https://github.com/user-attachments/assets/1a450790-d632-419e-8b4b-5cfea14a9b5d)
![image](https://github.com/user-attachments/assets/7781113e-c148-4a87-8fc8-7cb4422d28e3)
## 프로토타이핑(사용 툴: 피그마)
https://github.com/user-attachments/assets/b0f94e11-897d-40cd-ad46-a47730ed2351
## 페이지 구현  
1. main_screen.dart - 홈 화면이며, 유형별 학습을 하는 공간입니다. 각 유형 클릭 시, 유형 학습을 할 수 있는 화면으로 전환됩니다. 선지를 클릭하면 채점 화면으로 전환되며, 다음 문제로 넘어갈 수 있습니다.
2. practice_screen.dart - 학년별 모의고사를 푸는 공간입니다. 각 학년 클릭 시, 연도별, 월별 모의고사를 선택하는 화면으로 전환됩니다.
3. notes_screen.dart - 오답 문항들을 복습할 수 있는 공간입니다.
4. stats_screen.dart - 누적 성적을 확인할 수 있는 공간입니다.
## 구현 영상
https://github.com/user-attachments/assets/2c60884c-e1dd-4ddd-a847-ba3e1387a64c
## 회고
실제로 어플을 만들 경우에는 훨씬 더 많은 화면 전환이 필요할 것이다. 게다가 수많은 문항들을 텍스트로 넣고, 각 문항에 대해 채점하는 기능까지 구현하려면 어떻게 해야할지 지금으로서는 감도 안 잡힌다. 
