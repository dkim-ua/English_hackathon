import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

import '../../class/voice_assistant_stt.dart';

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
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(languages[1]);
    ttsSpeakStart();
  }

  void ttsSpeakStart(){
    if (isVoiceAssistant == true) {
      voiceAssistantTextToSpeech.speak("Чи є у вас акаунт? Скажіть:"
          "Якщо так - увійти, "
          "якщо ні - реєстрація", "uk-UA");
    }
  }
  final List<Image> carouselItems = [Image.asset('lib/images/slide1.png'), Image.asset('lib/images/slide2.png'), Image.asset('lib/images/slide3.png')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                context.router.push(const RegisterRoute());
              },
            ),
            const SizedBox(height: 10.0,),
            TextButton(
              style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
              color: mainColor,
              width: 1,
            ),
              borderRadius: BorderRadius.circular(18.0)),),),
              child: Text('ВЖЕ МАЮ АККАУНТ', style: TextStyle(fontSize: 24, color: mainColor),),
              onPressed: () {
                // Handle I already have an account
                voiceAssistantTextToSpeech.stop();
                context.router.push(const GeneralRoute());
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
