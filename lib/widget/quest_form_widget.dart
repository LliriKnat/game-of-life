import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:game_of_life/model/reward_model.dart';
import 'package:game_of_life/data/quest_db.dart';

class QuestFormWidget extends StatelessWidget {
  final String? name;
  final String? summary;
  final int? difficulty;
  final int? estimated_duration;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedSummary;
  final ValueChanged onChangeDifficulty;
  final ValueChanged<String> onChangeDate;
  final ValueChanged<String> onChangeTime;
  final ValueChanged<String> onChangePlace;
  final ValueChanged onChangeReward;
  final String? place;
  final String? status;
  final String? date;
  final String? time;
  final String? name_r;

  QuestFormWidget({
    Key? key,
    this.name = '',
    this.summary = '',
    this.difficulty = 1,
    this.estimated_duration = 0,
    required this.onChangedName,
    required this.onChangedSummary,
    required this.onChangeDifficulty,
    required this.onChangeDate,
    required this.onChangeTime,
    required this.onChangePlace,
    required this.onChangeReward,
    this.place = '',
    this.status = '',
    this.date = '',
    this.time = '',
    this.name_r = 'Посмотреть ютубчик',
  }) : super(key: key);
  static var menuItems = <int>[1, 2, 3];
  final List<DropdownMenuItem<int>> _dropdownMenuItems = menuItems
      .map((int value) => DropdownMenuItem<int>(
            value: value,
            child: Text('$value'),
          ))
      .toList();

  //мне это не нравится, но захардкодим список наград.
  static var rewardItems = <String>[
    'Посмотреть ютубчик',
    'Поиграть в игры',
    'Купить вкусняшку',
    'Погулять',
    'Поспать'
  ];
  final List<DropdownMenuItem<String>> _dropdownRewardItems = rewardItems
      .map((String value) =>
          DropdownMenuItem(value: value, child: Text('$value')))
      .toList();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            const SizedBox(
              height: 8,
            ),
            buildSummary(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildDate(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildTime(),
                  ),
                ],
              ),
            ),
            buildPlace(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildDifficulty(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildReward(),
                  )
                ],
              ),
            )
          ],
        ),
      ));

  Widget buildName() => TextFormField(
        maxLength: 15,
        maxLines: 1,
        initialValue: name,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Название квеста',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Заполните название квеста' : null,
        onChanged: onChangedName,
      );

  Widget buildSummary() => TextFormField(
        maxLength: 255,
        maxLines: 5,
        initialValue: summary,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Описание квеста',
        ),
        validator: (summary) =>
            summary != null && summary.isEmpty ? 'Заполните описание' : null,
        onChanged: onChangedSummary,
      );

  Widget buildDifficulty() => DropdownButtonFormField(
      value: difficulty,
      onChanged: onChangeDifficulty,
      style: TextStyle(
        color: Colors.white,
      ),
      items: this._dropdownMenuItems,
      dropdownColor: Color(0xff2D2D2D),
      borderRadius: BorderRadius.circular(5.0),
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xff818181)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xff818181)),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ));

  Widget buildDate() => DateTimePicker(
        initialValue: date,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 170),
          prefixIcon: ImageIcon(
            AssetImage('assets/calendar_normal.png'),
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Дата',
        ),
        type: DateTimePickerType.date,
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2100),
        validator: (value) {
          return null;
        },
        onChanged: onChangeDate,
      );

  Widget buildTime() => DateTimePicker(
        initialValue: time,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 50, maxWidth: 120),
          prefixIcon: ImageIcon(
            AssetImage('assets/clock2_normal.png'),
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Время',
        ),
        type: DateTimePickerType.time,
        validator: (value) {
          return null;
        },
        onChanged: onChangeTime,
      );

  Widget buildPlace() => TextFormField(
        maxLength: 100,
        maxLines: 1,
        initialValue: place,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIcon: ImageIcon(
            AssetImage('assets/guide_normal.png'),
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff818181)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: 'Место',
        ),
        onChanged: onChangePlace,
      );

  Widget buildReward() => DropdownButtonFormField(
      value: name_r,
      onChanged: onChangeReward,
      style: TextStyle(
        color: Colors.white,
      ),
      items: this._dropdownRewardItems,
      dropdownColor: Color(0xff2D2D2D),
      borderRadius: BorderRadius.circular(5.0),
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 200),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xff818181)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xff818181)),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ));
}
