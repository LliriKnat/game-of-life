import 'package:flutter/material.dart';
import 'package:game_of_life/model/quest_model.dart';
import 'package:game_of_life/screen/create_quest.dart';

import '../data/quest_db.dart';

class QuestCardWidget extends StatelessWidget {
  QuestCardWidget({
    Key? key,
    required this.quest,
    required this.index,
  }) : super(key: key);

  final Quest quest;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff2D2D2D);
    final name = quest.name;
    final summary = quest.summary;
    final difficulty = quest.difficulty;
    final status = quest.status;
    final date = quest.date;
    final time = quest.time;
    final name_r = quest.name_r;

    return Card(
      color: color,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 100),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xff2D2D2D),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 4),
                  spreadRadius: 1,
                  blurRadius: 8,
                  blurStyle: BlurStyle.normal),
            ],
            border: Border.all(
              width: 2,
              color: const Color(0xff818181),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            // строка с имеем квеста
            Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ]),
            // 3 кнопки взаимодействия
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // кнопка информации
                IconButton(
                    onPressed: () async {
                      _info_Builder(
                          context,
                          name,
                          summary,
                          status,
                          date,
                          time,
                          difficulty,
                          name_r); //Вызывает окно с описанием квеста. Вынесла, чтобы много места в коде не занимало
                    },
                    icon: ImageIcon(AssetImage("assets/info_normal1.png"),
                        color: Colors.white)),
                // кнопка редактирования
                IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => create_quest(
                                  quest: quest,
                                )),
                      );
                    }, // Это кнопка "Изменить". Она вызывает окно создания/редактирования квеста
                    icon: ImageIcon(AssetImage("assets/modify_normal.png"),
                        color: Colors.white)),
                Spacer(),
                // кнопка принятия квеста
                IconButton(
                  // padding: EdgeInsets.zero,
                  onPressed:
                      () async {
                    final quest = this.quest.copy(status: 'Принято');
                    await QuestsDatabase.instance.update(quest);
                      },
                  icon: const ImageIcon(AssetImage("assets/WMP_normal.png"),
                      color: Colors.white),
                  iconSize: 45,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // всплывающее окно с информацией
  Future<void> _info_Builder(BuildContext context, name, summary, status, date,
      time, difficulty, name_r) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titlePadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(3),
              backgroundColor: Color(0xff2D2D2D),
              title: Container(child: Text(name, textAlign: TextAlign.center)),
              content: Container(
                  constraints: BoxConstraints(minHeight: 200),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 9.0),
                      BoxShadow(
                          color: Color(0xff2D2D2D),
                          spreadRadius: -4.0,
                          blurRadius: 12.0)
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 30),
                    child: Text(
                        '$summary \n $date $time \n $difficulty \n $status \n $name_r',
                        textAlign: TextAlign.center),
                  )),
            ));
  }
}
