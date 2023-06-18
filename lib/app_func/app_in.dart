import 'package:flutter/material.dart';
import 'package:game_of_life/screen/HomePage.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Все должно быть оебрнуто в Material App читать доки Material App
    return MaterialApp(
      //Заголовок и тема
      title: 'GameOfLife',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.grey,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          dialogTheme: const DialogTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.grey,
            ),
            contentTextStyle: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.grey,
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.italic,
                fontSize: 18,
              )),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          dropdownMenuTheme: const DropdownMenuThemeData(
            textStyle: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.white,
            ),
          )),
      //Наше наполнение приложения - основаня страница с навигацией.
      home: MyHomePage(),
    );
  }
}
