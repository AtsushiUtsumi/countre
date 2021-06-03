import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'highScore.dart';
import 'global.dart';

void myInit(){
  print('初期化します');
  nextS = mat[mode][0];
  score = 0;
  next = 0;
  return;
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
Container cr() {
  return Container(
    color: Colors.transparent,
    //constraints: BoxConstraints.expand(),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                      'SOUND EFFECT:\n未定\nFONT:\nフォント\nICON:\nアイコン\nBACKGROUND:\n背景\nSPECIAL THANKS:\n生姜焼きのタレ\n:(c)2021 sinProject\n',
                      style: TextStyle(fontSize: 13,color: Colors.yellow)
                  ),
                )
            )
            //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: const Text('Leaderboard\n1位:佐藤\n2位:鈴木\n3位:高橋\n4位:田中\n5位:伊藤\n',style: TextStyle(fontSize: 15,color: Colors.yellow)),
                )
            ),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                border: Border.all(color: Colors.red)
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
          ),
        ),
      ],
    ),
  );
}

//以下ホームページのメイン
/////////////////////////////////////////////////////////////////////////
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//キーボードの崩れを防ぐ
      body: SafeArea(
        child: Stack(
          children: [
            Container(child: back,constraints: BoxConstraints.expand(),),
            Container(
                constraints: BoxConstraints.expand(), //これでいっぱいいっぱいに広がる
                child: Column(children: [
                  Expanded(flex: 2,child: highScoreBoard()),//試しにハイスコアボードオフ
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: const Text(
                              'Quick',
                              style: TextStyle(
                                  height: 0.9, color: Colors.white, fontSize: 35),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: const Text(
                              'Countre',
                              style: TextStyle(
                                  height: 0.9, color: Colors.white, fontSize: 35),
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          child: Align(
                            //child: TextField(onChanged: (value){pName = value;}),
                            child: Text(pName=='' ? 'プレーヤー名未入力':pName),
                          ),
                        ),
                        onTap: () {
                          _showMyDialog(context);
                        },
                      ),
                      width: 250,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(flex: 2, child: Container(padding: EdgeInsets.fromLTRB(20, 5,20,5),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red.withOpacity(mode==0 ? 0.2:0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1,
                                        color: Colors.red),
                                  ),
                                ),
                                onPressed: () {
                                  //if(!kIsWeb){player.play('a.mp3');print('音を鳴らしたかった');}
                                  setState(() {mode = 0;});
                                  },
                                child: Container(child: Text('1-30',style: TextStyle(color: Colors.white,fontSize: 20),)),
                              ),
                            )
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red.withOpacity(mode==1 ? 0.2:0), //ボタンそのものの色透過させたいのでこの設定
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1,
                                        color: Colors.red),
                                  ),
                                ),
                                onPressed: () {
                                  //if(!kIsWeb){player.play('a.mp3');}
                                  setState(() {mode = 1;});
                                  },
                                child: Text('A-Z',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                            )
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red.withOpacity(mode==2 ? 0.2:0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1,
                                        color: Colors.red),
                                  ),
                                ),
                                onPressed: () {
                                  //if(!kIsWeb){player.play('a.mp3');}
                                  setState(() {mode = 2;});
                                  },
                                child: Text('a-z',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                            )
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ElevatedButton(
                          onPressed: () {
                            il.shuffle();//ここで初めてシャッフル
                            //if(!kIsWeb)player.play('a.mp3');
                            myInit();
                            Navigator.of(context).pushNamed('/play');
                            },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.withOpacity(0.2), //ボタンそのものの色透過させたいのでこの設定
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.red),
                            ),
                          ),
                          child: Container(
                              child: const Align(child: const Text('PLAY!'),)
                          ),
                        ),
                      ),
                  ),
                  Expanded(
                    flex: 10,child: Container(padding:EdgeInsets.all(8.0),child: cr(),color: Colors.transparent,),
                  ),
                ]))
          ],
        ),
      ),
    );

  }
}

/////////////////////////////////////////////////////////////////////////////////以下ダイアログボックス関係
Future<void> _showMyDialog(BuildContext context) async {
  /////////////////////////////
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: sctest(context),
      );
    },
  );
}


Container sctest(BuildContext context){
  String _tmp = '';
  return Container(
    child: Row(
      children: [
        Expanded(flex: 3,child:TextField(onChanged: (value){_tmp = value;},),),
        Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: (){
                pName = _tmp;
                Navigator.pushNamed(context, '/home');
              },
              child: Text('OK'),
            )
        )
      ],
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////以上ダイアログ関連