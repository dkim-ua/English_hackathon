import 'package:english_hakaton/class/voice_assistant_stt.dart';
import 'package:english_hakaton/pages/authDirectory/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../class/constant.dart';

class MicroButton extends StatelessWidget{
  MicroButton({super.key, required this.voiceAssistantSpeechToText, required this.onTap});

  final VoiceAssistantSpeechToText voiceAssistantSpeechToText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.6),
          child: voiceAssistantSpeechToText.getRecognizing()
              ? const Icon(Icons.mic_off, color: Colors.white, size: 60)
              : const Icon(Icons.mic, color: Colors.white, size: 60,),
        )
    );
  }
}