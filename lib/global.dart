import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
final player = AudioCache();
bool shouldMove = false;//時の流れを止めたいときはfalseにしとくガスの元栓みたいな感じ
const int numOfCards = 30;
String pName = '吉田';
int mode = 0;
String nextS = mat[mode][0];
int next = 1;
int score = 0;
var il = List.generate(numOfCards, (index) => index); //これはプレイボタン押された時シャッフルする。
int outms = 0;//表示するべきタイマーのミリ秒PLAY!ボタンで0に初期化
/////////////////////////////////////////////

final back = Image.asset('images/bg.jpg',fit: BoxFit.cover);
const modeName = ['1-30','A-Z','a-z'];
final _mode1 = List<String>.generate(30, (index) => (index + 1).toString());
final _mode2 = List<String>.generate(30, (index) => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ    '[index]);
final _mode3 = List<String>.generate(30, (index) => 'abcdefghijklmnopqrstuvwxyz    '[index]);
final mat = [_mode1, _mode2, _mode3]; //こっちは正解のリスト。降順でいじらない。
final List<int> defaultRest = [30, 26, 26]; //何個突破すればクリアかをここで設定する
const int inf = 100000;//100秒以上は不可
int rest = defaultRest[mode];

String ms2str(int ms,{end=''}){//ミリ秒から文字列に変換
  //TODO: 0パディング
  return ms<inf ? (ms/100).toString().padLeft(4,'0')+end:'---';
}

Map<String,List<int>> data = {};
void setUserData(String username,int mode,int score){//ハイスコアを登録
  print(pName+'のデータをセット'+score.toString());print(data);
  if(mode<0 || mode>2){print('不正なモード : '+mode.toString());return;}
  if(data.containsKey(username)){
    if(data[username]![mode]>score){data[username]![mode] = score;}
  }else{
    data[username] = [inf,inf,inf];
  }
  print(pName+'のデータをセット'+score.toString());print(data);
  return;
}

String getUserData(String username,int mode){//スコアを取得ご新規さんなら未プレイ初期登録

  if(data.containsKey(username)){
    int scoreTmp = (data[username]![mode]);
    if(scoreTmp<inf){print(pName+'のデータを取得['+mode.toString()+'] = '+scoreTmp.toString());
      final _tmp = scoreTmp.toString().padLeft(4,'0');
      if(_tmp[0]=='0'){return _tmp[1]+'.'+_tmp[2]+_tmp[3]+'s';}else{return _tmp[0]+_tmp[1]+'.'+_tmp[2]+_tmp[3]+'s';}
    }else{return '---';}
  }else{
    setUserData(username, mode, inf);
    return '---';
  }
}
