import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;

import '../apis/wallet_api.dart';
import '../models/seed_phrase.dart';

class SeedPhraseProvider extends ChangeNotifier {
  init() async {
    // _phrases = await WalletAPI().getSeedPhrase();
    // print(_phrases!.mnemonic);
    // _phrasesList.addAll(_phrases!.mnemonic.split(' '));
    // print(_phrasesList);
    //TODO: make it random
    _phrasesList = words.all;
    print(_phrasesList);
    Random random = Random();
    _firstIndex = random.nextInt(12);
    do {
      _secondIndex = random.nextInt(12);
    } while (_secondIndex == _firstIndex);
    do {
      _thirdIndex = random.nextInt(12);
    } while (_thirdIndex == _secondIndex || _thirdIndex == _firstIndex);
    _firstWord = _phrasesList[_firstIndex];
    _secondWord = _phrasesList[_secondIndex];
    _thirdWord = _phrasesList[_thirdIndex];
    print(
      '$_firstIndex : $_firstWord , $_secondIndex : $_secondWord , $_thirdIndex : $_thirdWord',
    );
  }

  // SeedPhrase? _phrases;
  List<String> _phrasesList = <String>[];
  late int _firstIndex;
  late int _secondIndex;
  late int _thirdIndex;
  late String _firstWord;
  late String _secondWord;
  late String _thirdWord;

  List<String> get phraselist => _phrasesList;
  // String get phrase => _phrases!.mnemonic;

  String get firstWord => _firstWord;
  String get secondWord => _secondWord;
  String get thirdWord => _thirdWord;

  int get firstIndex => _firstIndex;
  int get secondIndex => _secondIndex;
  int get thirdIndex => _thirdIndex;

  List<String> hintForFirstPhrase() {
    List<String> temp = <String>[];
    temp.add(_firstWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }

  List<String> hintForSecondPhrase() {
    List<String> temp = <String>[];
    temp.add(_secondWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }

  List<String> hintForThirdPhrase() {
    List<String> temp = <String>[];
    temp.add(_thirdWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }
}
