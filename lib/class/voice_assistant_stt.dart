import 'dart:async';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

const int kAudioSampleRate = 16000;
const int kAudioNumChannels = 1;

class VoiceAssistantSpeechToText {
  VoiceAssistantSpeechToText({required this.language, required this.enumCurrentState});


  String language;
  String enumCurrentState;
  final RecorderStream _recorder = RecorderStream();
  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  Future<void> streamingRecognize() async {
    voiceAssistantTextToSpeech.stop();
    HapticFeedback.vibrate();
    print('start');
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();

      recognizing = true;
    final serviceAccount = ServiceAccount.fromString(r'''{
  "type": "service_account",
  "project_id": "future-simple-progect",
  "private_key_id": "8c223e9b54b81f0b3c5cf626ae6f0472de47e81e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDQiNrk7Gs7z2z7\n+ljrIPcWRuG1kVLL3WPIz94vwf5se6WLuDospvrI8U9TxN1bU3VMmjvQMP6A0gRI\n3i24NBt7URLlw1Lw/zAjsDfSsfPkye1BKo2XMX0mqo2UbjKh07L8yeOsIWtQ7WF+\ns8gTZ79MNK2kJut4DEOB5aV2vF8/8U91L2yAvc45m1cv2HUAYgKAPq/NoDcy9ycX\nwbRURdgj1Ek4QLjuL4NK4/onDRhiMb/NMI7XoD1HiTVZa13QMienuPrU7r1kfelY\nc+F4g9YWkof699hiw+vqCxHnSeccs4s8JafNMJ5c8K1XsrezuybnRbWXu+6tLmtH\nzXY9fcXnAgMBAAECggEAHma6lWyLcZZwNV1ZAJEMv02pctad3c9dJcB64Ywu8v0l\nCZ/bs04gpOeGgMLkNn/jS5NMrFxdg3BFZE4nwiwD5FAnKMyiAd+3fUHKfEf/M4KQ\nuShiqKvJVWLAmJFm25rJBFDL2qNV9DVh5PPWyPrIs8EWSNEiZkemFoDhRNR6L7r9\n9Qlg1obG/VfPiu7986rcu7UHygukUyNLcf4mQlK9qB9TjW+rdgXFkeaw5h/6yTCS\nm9BVwrlPEEVtClcAvjr92TicJ0gT4iDXT7reE9onnj4zKGNB6t0oHXgylqyPKKmB\nBjTAteG8jqlflqOIJ1nAZ2jtOxj+GCQoEwmth2RBoQKBgQDuyfZwKsGZodzutf06\nJvwV5XvXbof0pEthRRGv5FFAnKH1qgjWZx1EW9FgLuI5uIVjimN68hXhtYoYwIUT\nz740xyfZfsBSNmDhegeC7rTcO1zKJEk6EaM/uXNfFf3tI897YXQW2zD4Q3l3UhIw\nXXhPqTOJl7RzH3//+G5o132lMQKBgQDfkKbWBdhnUdopND1lzy+FfEjfvOFpU0vl\njGiT06pRsoXsgLVGc38TndW2cpNAzhzUZTuo1/aBJZwwOcwQd/Gn3ablFqe6p6iw\nE3P5nMN6R1+udf0k0fXyCw33Wfg7PudttDkljikh2dKSgYvyiNL7XZS49FUCwMVg\nP294i9k2lwKBgDOHBVTDBS/fy8r/Hnuz+eXHtWeRhGj4IwQEYYKxJA9rPU/Dt1B8\nw8YCgjXdKBgIh1Aphrn7D1m7UOdyc8UIqSS+bQzz2xBih5lgOcq5M/HqJWXBWsPb\nFn0jyY+VMUxA0/7t0p00A2cvOEDVRvOE1/doraRdRiUpgPd9ZmXdSlGhAoGAHmh8\naMvuvU7iz4vtdfWSTyOyfcwhFMRhpF1OtBysI+SWVq7C+UwoUrC7Ks+2u6/NOA50\n6OhG/RXygpS57tuBoQWC99H3CmpXhWt/8MmjxPQETaR6xBFS1JMwWR6Bpv1NWRyU\nUUleyt3nyEmakWiO2eXGnsmM7ozty8OVE95hsw0CgYEAwiw/1duWWifwpmIttl1t\n0kCoUWLXUPaMJBqkVzt6EP5KOxeoLT6CSFVOUkWTQu6pYra0jkBxk0LOlbxk9fuK\nupNoChBRWJCow6URL9fYmU4bwSxRdzL4xHl+yklg3JgbNa9BPvdsDduhCE58Htum\nUr2LT/SIP4fj949nipGLceY=\n-----END PRIVATE KEY-----\n",
  "client_email": "lang-ai@future-simple-progect.iam.gserviceaccount.com",
  "client_id": "101169109145489759109",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/lang-ai%40future-simple-progect.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}''');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig(language);

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream!);

    var responseText = '';

    responseStream.listen((data) {
      final currentText =
      data.results.map((e) => e.alternatives.first.transcript).join('\n');

      if (data.results.first.isFinal) {
        responseText += '\n' + currentText;
          text = responseText;
          recognizeFinished = true;
      } else {
          text = responseText + '\n' + currentText;
          recognizeFinished = true;
      }
    }, onDone: () {
        recognizing = false;
    });
  }


  Future<String> stopRecording() async {
    await Future.delayed(const Duration(seconds: 1));
    HapticFeedback.vibrate();
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
      recognizing = false;
      print(text);
      print('end');
    return _sstFetchData();
  }

  RecognitionConfig _getConfig(String language) =>
      RecognitionConfig(
          encoding: AudioEncoding.LINEAR16,
          model: RecognitionModel.basic,
          enableAutomaticPunctuation: true,
          sampleRateHertz: 16000,
          languageCode: language
      );

  bool getRecognizing(){
    return recognizing;
  }

  Future<String> _sstFetchData() async {
    final response = await http.get(Uri.http(baseIP, '/api/v1/voice-assistant/get-next-state', {
      'currentState': enumCurrentState, // Replace with your chatId
      'request': text, // Replace with your userId
    }));

    try {
      if (response.statusCode == 200) {
        //Map<String, dynamic> jsonResponseChat = jsonDecode(response.body);

        print('Ответ сервера: ${response.body}');
        var answer = response.body;
        return answer;
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during the request: $e';
    }
  }


}