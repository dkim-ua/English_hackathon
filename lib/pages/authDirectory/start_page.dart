import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

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
    ttsSpeakPage();
  }

  void ttsSpeakPage(){
    if (isVoiceAssistant == true) {
      VoiceAssistantTextToSpeech().speak("Чи є у вас акаунт? Якщо так - скажіть увійти, якщо ні - скажіть реєстрація", "uk-UA");
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
                VoiceAssistantTextToSpeech().stop();
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
                VoiceAssistantTextToSpeech().stop();
                context.router.push(const LoginRoute());
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
