import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/enums/enum_current_state.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

import '../../class/voice_assistant_stt.dart';
import '../../theme/micro_button.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;

@RoutePage()
class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[1],
        enumCurrentState: EnumCurrentState.startPageCurrentState.serverType());
    ttsSpeakStart();
  }

  void ttsSpeakStart(){
    if (isVoiceAssistant == true) {
      voiceAssistantTextToSpeech.speak("Інструкція щодо використання голосовим асистентом:"
          "Перед тим як промовити команду - натисніть в будь яку точку на екрані Вашого смартфону"
          "Після закінчення промови - ще раз натисніть на екран"
          "Для того щоб вимкнути голосового асистента скажіть - Вимкни голосового асистента"
          "Чи готові ви перейти далі?", languages[1]);
    }
  }

  final List<Image> carouselItems = [Image.asset('lib/images/slide1.png'), Image.asset('lib/images/slide2.png'), Image.asset('lib/images/slide3.png')];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Image.asset('lib/images/vector1.png'),
                ),
                //Image.network(''),
                CarouselSlider(
                  items: carouselItems,
                  options: CarouselOptions(
                    height: 367.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),),),
                  child: Text('ПОЧАТИ', style: TextStyle(fontSize: 24, color: backgroundColor,)),
                  onPressed: () {
                    voiceAssistantTextToSpeech.stop();
                    context.router.replace(const RegisterRoute());
                  },
                ),
                // const SizedBox(height: 10.0,),
                // TextButton(
                //   style: ButtonStyle(
                //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //   side: BorderSide(
                //   color: mainColor,
                //   width: 1,
                // ),
                //   borderRadius: BorderRadius.circular(18.0)),),),
                //   child: Text('ВЖЕ МАЮ АККАУНТ', style: TextStyle(fontSize: 24, color: mainColor),),
                //   onPressed: () {
                //     // Handle I already have an account
                //     voiceAssistantTextToSpeech.stop();
                //     context.router.push(const GeneralRoute());
                //   },
                // ),
              ],
            ),
          ),
          ),
        ),
        isVoiceAssistant
            ? MicroButton(
          voiceAssistantSpeechToText: voiceAssistantSpeechToText,
          onTap: () {
            voiceAssistantSpeechToText.getRecognizing()
                ? YesNoUndefined(context)
                : voiceAssistantSpeechToText.streamingRecognize();
          },
        )
            : const SizedBox()
      ],
    );
  }
}

void YesNoUndefined(BuildContext context) async{
  var result = await voiceAssistantSpeechToText.stopRecording();
  switch(result.toString()){
    case "LOGIN":
      isVoiceAssistant = true;
      voiceAssistantTextToSpeech.stop();
      context.router.replace(const GeneralRoute());
      print('ona skazala DA');
  }
}
