import 'package:flutter/material.dart';
import 'package:game_of_life/widget/quest_card.dart';
import 'create_quest.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/model/quest_model.dart';

class quests_page extends StatefulWidget {
  quests_page({Key? key}) : super(key: key);

  @override
  State<quests_page> createState() => _quests_pageState();
}

class _quests_pageState extends State<quests_page> {
  @override
  // Widget build(BuildContext context) => Scaffold(
  Widget build(BuildContext context) {
    final _kTabs = <Tab>[
      const Tab(
        child: Text('Все квесты'),
      ),
      const Tab(
        child: Text('Мои квесты'),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xff2D2D2D),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 55,
              child: TabBar(tabs: _kTabs),
            ),
            Expanded(
                child: TabBarView(children: [
              FutureBuilder<List<Quest>>(
                future:
                    QuestsDatabase.instance.readAllQuests('Задание создано'),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Quest>> quests) {
                  if (quests.hasData) {
                    return ListView.builder(
                        itemCount: quests.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Quest quest = quests.data![index];
                          return QuestCardWidget(quest: quest, index: index);
                        });
                  } else {
                    return EmptyList(); // Исправить ошибку отображения, когда БД пустая
                  }
                },
              ),
              // quests.isEmpty ? EmptyList() : buildQuests(),
              FutureBuilder<List<Quest>>(
                future: QuestsDatabase.instance.readAllQuests('Принято'),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Quest>> quests) {
                  if (quests.hasData) {
                    return ListView.builder(
                        itemCount: quests.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Quest quest = quests.data![index];
                          return QuestCardWidget(
                              quest: quest,
                              index: index); // создать другую карточку
                        });
                  } else {
                    return EmptyList();
                  }
                },
              )
            ])), // Тут тоже нужно создать отдельную Future функцию для чтения только своих квестов
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2D2D2D),
        child: Image.asset('assets/add_normal.png', color: Colors.white),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => create_quest()),
          );
          await QuestsDatabase.instance.readAllQuests('Задание создано');
        },
      ),
    );
  }

  Widget EmptyList() {
    return Text('Пока квестов нет !!!');
  }
}
