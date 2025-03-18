# 수능 영어 공략 앱 설계하기
## 앱 정보
### 
- 앱 이름 : '수능 영어 공략'  
- 타겟 : 수능 영어를 대비하여 학습 중인 초,중,고등학생
- 주요 기능 :
    - 유형별 학습 공간에서 유튜브 강의 영상 시청 가능
    - 문제 풀이 화면에서 타이머 기능 탑재. 시간 경과시 자동으로 채점 화면으로 전환
    - 채점 화면에서 각 문항들 클릭 가능
    - 틀린 문항들 '저장하기' 버튼을 누르면 저장되어 '오답노트' 화면에서 확인 가능
    - '오답노트' 화면에서 문제 관리 가능

  
## 앱 구조도
![image](https://github.com/user-attachments/assets/25169256-2b42-41e5-bcfc-563db42900ba)
## 앱 와이어프레임 (사용 툴: 파워포인트)
![image](https://github.com/user-attachments/assets/04784989-d787-4409-9bcf-2003aac88846)
![image](https://github.com/user-attachments/assets/1a450790-d632-419e-8b4b-5cfea14a9b5d)
![image](https://github.com/user-attachments/assets/7781113e-c148-4a87-8fc8-7cb4422d28e3)
## 프로토타이핑(사용 툴: 피그마)
https://github.com/user-attachments/assets/b0f94e11-897d-40cd-ad46-a47730ed2351
## 페이지 구현  


https://github.com/user-attachments/assets/dfb0c181-1295-4456-8aa0-f94ebc41172f



1. main_screen.dart - 홈 화면이며, 각 유형 클릭 시, 유형 학습을 할 수 있는 화면으로 전환됩니다. 유형 학습에서 유튜브 강의 영상 시청 가능합니다. (유형별로 별도 파일 작성)
2. practice_screen.dart - 학년별 모의고사를 푸는 공간입니다. 각 학년 클릭 시, 연도별, 월별 모의고사를 선택하는 화면으로 전환됩니다. (별도 파일 작성)
3. notes_screen.dart - 오답 문항들을 복습할 수 있는 공간입니다.
4. stats_screen.dart - 누적 성적을 확인할 수 있는 공간입니다.

## 회고
pdf 파일을 텍스트로 변환하여 내가 원하는 양식에 맞게 JSON 파일로 만드는 데 시간이 많이 걸렸다. 파이썬으로 자동 변환한 후에도 따로 일일이 손봐야한다. 
그래도 기능들을 한 번 만들어놓으니 나중에는 복붙만 하면 돼서 편한 것 같다. 물론 코딩은 너무 어렵다..
