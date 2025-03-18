import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PurposeScreen extends StatefulWidget {
  @override
  _PurposeScreenState createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = YoutubePlayerController.fromVideoId(
      videoId: '_umJhUjgNsg',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableJavaScript: true,
        playsInline: true,
        mute: false,
        loop: false,
        strictRelatedVideos: true,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('목적 파악', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: player,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            '강의 영상',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '연습문제1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '밑줄 친 our brain and the universe meet가 다음 글에서 의미하는 바로 가장 적절한 것은?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Many people take the commonsense view that color is an objective property of things, or of the light that bounces off them. They say a tree’s leaves are green because they reflect green light―a greenness that is just as real as the leaves. Others argue that color doesn’t inhabit the physical world at all but exists only in the eye or mind of the viewer. They maintain that if a tree fell in a forest and no one was there to see it, its leaves would be colorless―and so would everything else. They say there is no such thing as color; there are only the people who see it. Both positions are, in a way, correct. Color is objective and subjective―“the place,” as Paul Cézanne put it, “where our brain and the universe meet.” Color is created when light from the world is registered by the eyes and interpreted by the brain.',
                    style: TextStyle(fontSize: 16,),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => _handleAnswerSelection(index),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            children: [
                              Text('${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Expanded(child: Text(answerOptions[index], style: TextStyle(fontSize: 16))),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  final int correctAnswer = 1;
  final List<String> answerOptions = [
    'we see things beyond the range of perception',
    'objects appear different by the change of light',
    'your perspectives and others’ reach an agreement',
    'our mind and physical reality interact with each other',
    'structures of the human brain and the universe are similar'
  ];

  void _handleAnswerSelection(int index) {
    if (index + 1 == correctAnswer) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CorrectScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IncorrectScreen()),
      );
    }
  }
}

// 정답 화면
class CorrectScreen extends StatelessWidget {
  final List<String> answerOptions = [
    'we see things beyond the range of perception',
    'objects appear different by the change of light',
    'your perspectives and others’ reach an agreement',
    'our mind and physical reality interact with each other',
    'structures of the human brain and the universe are similar'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정답입니다', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextQuestionScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '연습문제1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '밑줄 친 our brain and the universe meet가 다음 글에서 의미하는 바로 가장 적절한 것은?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Many people take the commonsense view that color is an objective property of things, or of the light that bounces off them. They say a tree’s leaves are green because they reflect green light―a greenness that is just as real as the leaves. Others argue that color doesn’t inhabit the physical world at all but exists only in the eye or mind of the viewer. They maintain that if a tree fell in a forest and no one was there to see it, its leaves would be colorless―and so would everything else. They say there is no such thing as color; there are only the people who see it. Both positions are, in a way, correct. Color is objective and subjective―“the place,” as Paul Cézanne put it, “where our brain and the universe meet.” Color is created when light from the world is registered by the eyes and interpreted by the brain.',
              style: TextStyle(fontSize: 16,),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.red[100] : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: index == 0 ? Colors.red : Colors.black,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Expanded(child: Text(answerOptions[index], style: TextStyle(fontSize: 16))),
                    ],
                  ),
                );
              }),

            ),
            SizedBox(height: 20),
            Text('해설',
              style: TextStyle(fontSize:16, color: Colors.red, fontWeight: FontWeight.bold), ),
            SizedBox(height: 20),
            Text("객관적인 것은 1번 문장에서 언급된 물리적 세계의 물리적 속성을 말하는 것이고, 주관적인 것은 3번 문장에서 언급된 우리의 정신 안에 있다는 것을 말하며, 색은 둘 다에 해당한다고 했고, 뒤의 8번 문장에서 물리적 세상의 빛이 뇌에 의해 해석된다고 했으므로, 함축적 의미는 '정신(우리의 뇌)과 우주(물리적 세계)의 상호작용'이 적절하다.",
              style:TextStyle(fontSize:16, fontWeight: FontWeight.bold),  )
          ],
        ),
      ),
    );
  }
}

class IncorrectScreen extends StatelessWidget {
  final List<String> answerOptions = [
    'we see things beyond the range of perception',
    'objects appear different by the change of light',
    'your perspectives and others’ reach an agreement',
    'our mind and physical reality interact with each other',
    'structures of the human brain and the universe are similar'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오답입니다', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextQuestionScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '연습문제1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '밑줄 친 our brain and the universe meet가 다음 글에서 의미하는 바로 가장 적절한 것은?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Many people take the commonsense view that color is an objective property of things, or of the light that bounces off them. They say a tree’s leaves are green because they reflect green light―a greenness that is just as real as the leaves. Others argue that color doesn’t inhabit the physical world at all but exists only in the eye or mind of the viewer. They maintain that if a tree fell in a forest and no one was there to see it, its leaves would be colorless―and so would everything else. They say there is no such thing as color; there are only the people who see it. Both positions are, in a way, correct. Color is objective and subjective―“the place,” as Paul Cézanne put it, “where our brain and the universe meet.” Color is created when light from the world is registered by the eyes and interpreted by the brain.',
              style: TextStyle(fontSize: 16,),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.red[100] : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: index == 0 ? Colors.red : Colors.black,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Expanded(child: Text(answerOptions[index], style: TextStyle(fontSize: 16))),
                    ],
                  ),
                );
              }),

            ),
            SizedBox(height: 20),
            Text('해설',
              style: TextStyle(fontSize:16, color: Colors.red, fontWeight: FontWeight.bold), ),
            SizedBox(height: 20),
            Text("객관적인 것은 1번 문장에서 언급된 물리적 세계의 물리적 속성을 말하는 것이고, 주관적인 것은 3번 문장에서 언급된 우리의 정신 안에 있다는 것을 말하며, 색은 둘 다에 해당한다고 했고, 뒤의 8번 문장에서 물리적 세상의 빛이 뇌에 의해 해석된다고 했으므로, 함축적 의미는 '정신(우리의 뇌)과 우주(물리적 세계)의 상호작용'이 적절하다.",
              style:TextStyle(fontSize:16, fontWeight: FontWeight.bold),  )
          ],
        ),
      ),
    );
  }
}

class NextQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다음 문제')),
      body: Center(child: Text('여기에 다음 문제가 표시됩니다.', style: TextStyle(fontSize: 20))),
    );
  }
}
