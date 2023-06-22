import 'package:flutter/material.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/widget/quest_form_widget.dart';
import 'package:game_of_life/model/quest_model.dart';

class create_quest extends StatefulWidget {
  final Quest? quest;

  const create_quest({
    Key? key,
    this.quest,
  }) : super(key: key);
  @override
  _create_questPageState createState() => _create_questPageState();
}

class _create_questPageState extends State<create_quest> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String summary;
  late int difficulty;
  late int estimated_duration;
  late String place;
  late String status;
  late String date;
  late String time;
  late String name_r;

  @override
  void initState() {
    super.initState();
    name = widget.quest?.name ?? '';
    summary = widget.quest?.summary ?? '';
    difficulty = widget.quest?.difficulty ?? 1;
    estimated_duration = widget.quest?.estimated_duration ?? 0;
    place = widget.quest?.place ?? '';
    status = widget.quest?.status ?? '';
    date = widget.quest?.date ?? '';
    time = widget.quest?.time ?? '';
    name_r = widget.quest?.name_r ?? 'Посмотреть ютубчик';
  }

  @override
  build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xff2D2D2D),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: addOrUpdateQuest,
                icon: const ImageIcon(AssetImage("assets/add_normal.png"),
                    color: Colors.blue))
          ],
        ),
        body: Form(
          key: _formKey,
          child: QuestFormWidget(
            name: name,
            summary: summary,
            difficulty: difficulty,
            estimated_duration: estimated_duration,
            onChangedName: (name) => setState(() => this.name = name),
            onChangedSummary: (summary) =>
                setState(() => this.summary = summary),
            onChangeDifficulty: (difficulty) =>
                setState(() => this.difficulty = difficulty),
            place: place,
            date: date,
            time: time,
            onChangeDate: (date) => setState(() => this.date = date),
            onChangeTime: (time) => setState(() => this.time = time),
            onChangePlace: (place) => setState(() => this.place = place),
            name_r: name_r,
            onChangeReward: (name_r) => setState(() => this.name_r = name_r),
          ),
        ),
      );

  void addOrUpdateQuest() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.quest != null;

      if (isUpdating) {
        await updateQuest();
      } else {
        await addQuest();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateQuest() async {
    final quest = widget.quest!.copy(
        name: name,
        summary: summary,
        difficulty: difficulty,
        estimated_duration: estimated_duration,
        place: place,
        date: date,
        time: time,
        name_r: name_r);
    await QuestsDatabase.instance.update(quest);
  }

  Future addQuest() async {
    // final point = ModalRoute.of(context)!.settings.arguments;
    print('AAAAAA $place');
    final quest = Quest(
        name: name,
        summary: summary,
        difficulty: difficulty,
        estimated_duration: estimated_duration,
        place: place,
        status: 'Задание создано',
        date: date,
        time: time,
        name_r: name_r);

    await QuestsDatabase.instance.create(quest);
  }
}