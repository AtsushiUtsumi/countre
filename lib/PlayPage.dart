import 'dart:async';
import 'package:flutter/material.dart';
import 'global.dart';

List<int> highScore = List.generate(3, (index) => 20000);
List<String> highScoreS = List.generate(3, (index) => '---');

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool shouldMove = false;//テロップを止めたいときはfalseにしとくガスの元栓みたいな感じ

  String timeBoard = '00.00';
  //左上のタイマーに表示する文字列XX.XXしかありえない
  // ストリームコントローラにしかアクセスを認めない

  final StreamController<String> _streamController = StreamController();
  //////////////////////////////////////
  int clearTime = 10000;
  bool timeMove = false;
  int startTime = 0;
  int _counter = 0;//これ
  Future<void> fun() async{
    if(!shouldMove){print('ストリームの元栓にロックがかかっています。shouldMove=trueにしてから呼んで下さい。');}
    if(timeMove){return;}//すでにタイマーが起動中
    timeMove = true;_counter = 0;clearTime = 10000;//ここで初めてタイマー起動処理

    startTime = DateTime.now().millisecondsSinceEpoch;
    while(shouldMove && _counter<9998){
      if(shouldMove){
        await Future<void>.delayed(Duration(milliseconds: 16));
        //print('タイマー動いとる');
        _incrementCounter();
      }
    }
    //print('タイマーループ終了');
    timeMove = false;shouldMove = false;timeBoard = '00.00';//_counter = 0;
    return;
  }
  void _incrementCounter() {//ここ放置少女で言えばテロップに流す処理時間
    _counter = DateTime.now().millisecondsSinceEpoch - startTime;
    _counter = (_counter~/10);if(_counter>9998){_counter = 9999;}
    if(_counter > clearTime){_counter = clearTime;}
    String tmp = _counter.toString().padLeft(4,'0');
    timeBoard = tmp[0] + tmp[1] + '.' + tmp[2] + tmp[3];
    _streamController.add(timeBoard);
  }
  //////////////////////////////////////

  void gameOver() {
    nowPlaying = 0;noTouch = true;setState(() {_scoreBoard = 'Game Over !';});
    shouldMove = false;
    timeMove = false;
  }

  void gameClear() {
    clearTime = _counter;//キャプチャ的な変数ゲーム開始時に初期化すべき

    setUserData(pName, mode, clearTime);

    print(_counter.toString()+'秒でクリア関数が呼ばれました。'+highScore[mode].toString());
    if(_counter < highScore[mode]){highScore[mode] = _counter;print(highScore[mode].toString()+'にハイスコア更新!!');}
    nowPlaying = 0;noTouch = true;setState(() {_scoreBoard = 'Congratulation!';});
    shouldMove = false;
    timeMove = false;
    return;
  }

  int nowPlaying = 0; //プレイ中なら1boolにすべきじゃない?
  bool noTouch = false;
  String _scoreBoard = nextS;



  Expanded numButton(id) {
    //このidは降順に与えられる
    return Expanded(
        child: ElevatedButton(
          child: Text(mat[mode][il[id]]),
          onPressed: () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    ///////

    return Scaffold(body: SafeArea(child: Stack(children: [Container(child: back,constraints: BoxConstraints.expand(),),
        Container(child: Column(children: [
                  Expanded(
                      flex: 3, //これで一番上のQUIT調節
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: StreamBuilder<String>(
                                  stream: _streamController.stream,
                                  initialData: '00.00',
                                  builder: (context, snapshot) {
                                    return Align(alignment: Alignment.center,child:Text(
                                      '${snapshot.data}',
                                      style: TextStyle(fontSize: 30, color: Colors.white),
                                    ),);
                                  }
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(right: 10,top: 5),
                                constraints: BoxConstraints.expand(),
                                //alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent, //ボタンそのものの色透過させたいのでこの設定
                                    shadowColor: Colors.transparent,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: Colors.red),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: const Text(
                                      'QUIT',
                                      style: TextStyle(fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    //初期化しないといけないのはこの5つだけ?
                                    nowPlaying = 0;
                                    shouldMove = false;
                                    timeMove = false;
                                    //_counter = 0;
                                    timeBoard = '00.00';
                                    startTime = 0;
                                    noTouch = false;
                                    Navigator.of(context).pushNamed('/home');
                                  }, //QUITボタンを押してリセット
                                ),

                                //child: Text('QUIT',style: TextStyle(fontSize: 30,color: Colors.white),),
                                //color: Colors.red,
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 10,
                      child: Container(
                          color: Colors.transparent,
                          child: Align(
                            child: Text(_scoreBoard, style: TextStyle(fontSize: 40, color: Colors.white),),
                            alignment: Alignment.center,
                          ))),

                  Expanded(
                    flex: 30,
                    child: Container(
                      width: 340,
                      color: Colors.transparent,
                      child: GridView.count(
                          mainAxisSpacing: 10, //行間幅調節
                          crossAxisSpacing: 10, //列間幅調節
                          physics: const NeverScrollableScrollPhysics(), //スクロール防止
                          crossAxisCount: 5, //列の数指定するけどほぼ必須とみていい
                          children: List.generate(numOfCards, (index) {
                            return Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                      Colors.transparent, //ボタンそのものの色透過させたいのでこの設定
                                      shadowColor: Colors.transparent,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 1,
                                            color: Colors.red),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (noTouch) {
                                        print('ボタンが押されたが受け付けない。');
                                        return;
                                      } //ノータッチモードでのタップは遷移を意味するのが良いかも。
                                      if (nowPlaying == 0) {
                                        nowPlaying = 1;
                                        shouldMove = true;
                                        fun();
                                      }
                                      //数字のボタン押したときの処理はここ
                                      //if(!kIsWeb){player.play('a.mp3');}
                                      //indexが押されたボタンのID
                                      //if(nextS==mat[mode][index]){//文字列比較バージョンに変更
                                      //nextはただただ++するのみ
                                      if (next == il[index]) {//正しいボタンを押した処理
                                          score++;
                                          next++; //これ不要にする
                                          if (next>2 || next > defaultRest[mode]) {//最後の押すべきボタン押した時
                                            //if(!kIsWeb)player.play('clear.mp3');
                                            gameClear();
                                          }else{
                                            //if(!kIsWeb)player.play('a.mp3');
                                            nextS = mat[mode][next];
                                            setState(() {_scoreBoard = nextS;});
                                          }
                                      } else {
                                        //if(!kIsWeb)player.play('over.mp3');
                                        gameOver();
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        mat[mode][il[index]],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )));
                          })),
                    ),
                  ),
                ]),),
    ],),),);

  }
}
