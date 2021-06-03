//スコアはミリ秒で管理します表示するためにどう加工するかは任せます

import 'package:flutter/material.dart';
import 'global.dart';


Container highScoreBoard(){
  return Container(
    constraints: BoxConstraints.expand(),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: const Text(
                  '1-30',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  getUserData(pName, 0),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: const Text(
                  'A-Z',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  getUserData(pName, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: const Text(
                  'a-z',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  getUserData(pName, 2),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
