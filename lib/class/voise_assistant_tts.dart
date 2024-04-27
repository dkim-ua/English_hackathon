import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'constant.dart';

enum TtsState { playing, stopped, paused, continued }

class VoiceAssistantTextToSpeech{
  late FlutterTts flutterTts;
  String? engine;
  double volume = 1.0;
  double pitch = 0.7;
  double rate = 0.52;
  bool isCurrentLanguageInstalled = false;
  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      print("Paused");
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      print("Continued");
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });

  }

  void ttsUndefined(){
    stop();
    speak('Я вас не зрозумів, повторіть будь ласка', languages[1]);
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future<void> speak(String newVoiceText, String language) async{
    await flutterTts.setLanguage(language);
    // if(language == 'uk-UA') {
    //   flutterTts.setVoice({"name": "Lesya", "locale": 'uk-UA'});
    // } else {
    //   flutterTts.setVoice({"name": "Karen", "locale": 'en-US'});
    // }
    if (isAndroid) {
      await flutterTts
          .isLanguageInstalled(language)
          .then((value) => isCurrentLanguageInstalled = (value as bool));
    }

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (newVoiceText.isNotEmpty) {
      await flutterTts.speak(newVoiceText);
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> stop() async {
    var result = await flutterTts.stop();
    if (result == 1) () => ttsState = TtsState.stopped;
  }

  Future<void> pause() async {
    var result = await flutterTts.pause();
    if (result == 1) () => ttsState = TtsState.paused;
  }

}