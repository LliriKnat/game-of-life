import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'Stats.dart';
import 'quests.dart';
import 'settings.dart';
import 'profile.dart';
import 'map.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/model/quest_model.dart';

const _kPages = <String, ImageIcon>{
  'Главная': ImageIcon(
    AssetImage("assets/info_normal.png"),
    color: Colors.grey,
  ),
  'Карта': ImageIcon(
    AssetImage("assets/world1_normal.png"),
    color: Colors.grey,
  ),
  'Квесты': ImageIcon(
    AssetImage("assets/book_normal.png"),
    color: Colors.grey,
  ),
  'Отчет': ImageIcon(
    AssetImage("assets/stats_normal.png"),
    color: Colors.grey,
  ),
  'Настройки': ImageIcon(
    AssetImage("assets/setting_normal.png"),
    color: Colors.grey,
  ),
};

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TabStyle _tabStyle = TabStyle.textIn;
  int selectedPage = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Основная страница с текущим заданием и инвентарем
    profile_page(),
    // Страница 2
    MapPage(),
    // Страница создания квестов а так же расстановки их в расспсание
    quests_page(),
    // ...
    stats_page(),
    // Страница 5
    setting_page(),
    //Вы можете сделать и больше страниц.
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: const Color(0xff2D2D2D), // 0xff + Hex Code
          body: Container(
              padding: const EdgeInsets.only(top: 28),
              child: _widgetOptions.elementAt(selectedPage)),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: Colors.black45,
            style: _tabStyle,
            items: <TabItem>[
              for (final entry in _kPages.entries)
                TabItem(
                    icon: entry.value, title: entry.key, fontFamily: 'Inter'),
            ],
            onTap: _onItemTapped,
          ),
        ));
  }
}
