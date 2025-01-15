# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 김선
- 리뷰어 : 고은


# PRT(Peer Review Template)
- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
        - 중요! 해당 조건을 만족하는 부분을 캡쳐해 근거로 첨부
        - <img width="418" alt="image" src="https://github.com/user-attachments/assets/4e2dfde3-5eda-471f-87fd-72358dc8c968" />

    
- [x]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
  주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭을 왜 핵심적이라고 생각하는지 확인
    - 해당 코드 블럭에 doc string/annotation이 달려 있는지 확인
    - 해당 코드의 기능, 존재 이유, 작동 원리 등을 기술했는지 확인
    - 주석을 보고 코드 이해가 잘 되었는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - <img width="571" alt="image" src="https://github.com/user-attachments/assets/188eac7e-4ee1-4030-9326-2832a7e06f6c" />
        <img width="462" alt="image" src="https://github.com/user-attachments/assets/d7b236f5-213d-4086-a0f5-49db7eed4f4e" />


  
- [x]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
  새로운 시도 또는 추가 실험을 수행해봤나요?**
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인
    - 프로젝트 평가 기준에 더해 추가적으로 수행한 나만의 시도, 
      실험이 기록되어 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - 2번 사진 첨부 참
  
- [x]  **4. 회고를 잘 작성했나요?**
    - 주어진 문제를 해결하는 완성된 코드 내지 프로젝트 결과물에 대해
    배운점과 아쉬운점, 느낀점 등이 기록되어 있는지 확인
    - 전체 코드 실행 플로우를 그래프로 그려서 이해를 돕고 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - <img width="569" alt="image" src="https://github.com/user-attachments/assets/dba5e912-1c8d-4693-9766-b55241e58ab2" />

    
- [x]  **5. 코드가 간결하고 효율적인가요?**
    - 파이썬 스타일 가이드 (PEP8) 를 준수하였는지 확인
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 함수화/모듈화했는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - <img width="458" alt="image" src="https://github.com/user-attachments/assets/c08a3f32-a921-44a7-9a07-f1238b1279df" />



# 회고(참고 링크 및 코드 개선)
```
5번 내용과 관련해서 배울 점이 많다고 느꼈습니다.
num1과 num2의 연산을 result라는 변수에 할당해주고
결과 값을 print를 할 때 포맷팅을 활용해 print의 반복을 축소시켰습니다.

또 어차피 각각 연산자에 대한 연산을 적어야 하므로
연산자 리스트를 만들어 논리 연산자로 직접 확인 할 필요 없이
각각 연산자가 operator(+,-,*,/,**)에 해당하는지 확인할 수 있었습니다.

그리고 operator이라는 내장된 함수를 사용해 따로 operator을 정의해줄 필요도 없었습니다. 
```
