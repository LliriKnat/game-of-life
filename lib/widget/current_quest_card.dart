import 'package:flutter/material.dart';
import 'package:game_of_life/model/quest_model.dart';

import '../data/quest_db.dart';

class CurrentQuestCard extends StatelessWidget {
  CurrentQuestCard({
    Key? key,
    required this.quest,
  }) : super(key: key);

  final Quest quest;

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff2D2D2D);
    final name = quest.name;
    final summary = quest.summary;
    final difficulty = quest.difficulty;
    final status = quest.status;
    final date = quest.date;
    final time = quest.time;

    return Card(
        color: color,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 55),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xff2D2D2D),
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
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  _finish_Builder(context, name);
                },
                child: Text(name),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    _info_Builder(context, name, summary, status, date, time,
                        difficulty); //Вызывает окно с описанием квеста. Вынесла, чтобы много места в коде не занимало
                  },
                  icon: const ImageIcon(AssetImage("assets/info_normal1.png"),
                      color: Colors.white)),
            ],
          ),
        ));
  }

  Future<void> _finish_Builder(BuildContext context, name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titlePadding: const EdgeInsets.all(20),
              contentPadding: const EdgeInsets.all(3),
              backgroundColor: const Color(0xff2D2D2D),
              title: Text(name, textAlign: TextAlign.center),
              content: Container(
                alignment: AlignmentDirectional.center,
                constraints: const BoxConstraints(maxHeight: 80),
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
                child: const Text('Завершить задание?',
                    textAlign: TextAlign.center),
              ),
              actions: [
                IconButton(
                  iconSize: 40,
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  icon: const ImageIcon(AssetImage("assets/cancel_normal.png"),
                      color: Colors.white),
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  icon: const ImageIcon(AssetImage("assets/ok_normal.png"),
                      color: Colors.blue),
                ),
              ],
            )).then((value) {
      if (value == 'OK') {

        void endMission() async {
          var quest = this.quest.copy(status: 'sadjd');
          await QuestsDatabase.instance.update(quest);
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Задание завершено')));
      }
    });
  }

  Future<void> _info_Builder(
      BuildContext context, name, summary, status, date, time, difficulty) {
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
                  decoration: BoxDecoration(
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
                        '$summary \n $date $time \n $difficulty \n $status',
                        textAlign: TextAlign.center),
                  )),
            ));
  }
}
