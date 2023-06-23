import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class stats_page extends StatelessWidget {
  const stats_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: <Widget>[
            const SizedBox(width: 20.0, height: 100.0),

            const Text(
              'Тут может быть',
              style: TextStyle(fontSize: 40.0),

            ),
            const SizedBox(width: 20.0, height: 100.0),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 50.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('отчет'),
                  RotateAnimatedText('статистка'),
                  RotateAnimatedText('ваша реклама'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
