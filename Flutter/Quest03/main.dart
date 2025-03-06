import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: OneScreen(is_egg:true),
    );
  }
}

class OneScreen extends StatelessWidget {
  final bool is_egg;
  OneScreen({required this.is_egg});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: Icon(FontAwesomeIcons.cat),
              title: Center(
                child: Text('계란말이'),
              ),),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Next'),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TwoScreen(is_egg:false)),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap:() {
                      print("계란이야?: $is_egg");
                    },
                    child:  Image(
                    image: AssetImage('images/계란말이.jpg'),
                      width: 300, height: 300,
                  ),
                  ),
                ]
              ))
            )
        );
  }
}


class TwoScreen extends StatelessWidget {
  final bool is_egg;
  TwoScreen({required this.is_egg});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: Icon(FontAwesomeIcons.cat),
              title: Center(
                child: Text('닭볶음탕'),
              ),),
            body: Center(
              child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Back'),
                    onPressed: (){
                      Navigator.pop(
                        context,
                        true,
                      );
                    },
                  ),
                  GestureDetector(
                    onTap:() {
                      print("계란이야?: $is_egg");
                    },
                    child:  Image(
                      image: AssetImage('images/닭볶음탕.jpg'),
                      width: 300, height: 300,
                    ),
                  ),
                ]
            )
            )
        )
    );
  }
}
//회고: gesturedetector를 써서 이미지 클릭시 문구가 프린트되도록 만들었다.
