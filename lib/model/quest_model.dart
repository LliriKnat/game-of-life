import 'package:game_of_life/model/reward_model.dart';

const String tableQuests = 'quest';

class QuestFields {
  static final List<String> values = [
    id,
    name,
    summary,
    difficulty,
    difficulty,
    estimated_duration,
    place,
    status,
    date,
    time,
    name_r
  ];
  static const String id = '_id';
  static const String name = 'name';
  static const String summary = 'summary';
  static const String difficulty = 'difficulty';
  static const String estimated_duration = 'estimated_duration';
  static const String place = 'place';
  static const String status = 'status';
  static const String date = 'date';
  static const String time = 'time';
  static const String name_r = 'name_r';
}

class Quest {
  final int? id;
  final String name;
  final String summary;
  final int difficulty;
  final int estimated_duration;
  final String? place;
  final String status;
  final String? date;
  final String? time;
  final String? name_r;

  const Quest({
    this.id,
    required this.name,
    required this.summary,
    required this.difficulty,
    required this.estimated_duration,
    this.place,
    required this.status,
    this.date,
    this.time,
    this.name_r,
  });

  Quest copy({
    int? id,
    String? name,
    String? summary,
    int? difficulty,
    int? estimated_duration,
    String? place,
    String? status,
    String? date,
    String? time,
    String? name_r,
  }) =>
      Quest(
          id: id ?? this.id,
          name: name ?? this.name,
          summary: summary ?? this.summary,
          difficulty: difficulty ?? this.difficulty,
          estimated_duration: estimated_duration ?? this.estimated_duration,
          place: place ?? this.place,
          status: status ?? this.status,
          date: date ?? this.date,
          time: time ?? this.time,
          name_r: name_r ?? this.name_r);

  static Quest fromJson(Map<String, Object?> json) => Quest(
        id: json[QuestFields.id] as int?,
        name: json[QuestFields.name] as String,
        summary: json[QuestFields.summary] as String,
        difficulty: json[QuestFields.difficulty] as int,
        estimated_duration: json[QuestFields.estimated_duration] as int,
        place: json[QuestFields.place] as String,
        status: json[QuestFields.status] as String,
        date: json[QuestFields.date] as String,
        time: json[QuestFields.time] as String,
        name_r: json[QuestFields.name_r] as String,
      );

  Map<String, Object?> toJson() => {
        QuestFields.id: id,
        QuestFields.name: name,
        QuestFields.summary: summary,
        QuestFields.difficulty: difficulty,
        QuestFields.estimated_duration: estimated_duration,
        QuestFields.place: place,
        QuestFields.status: status,
        QuestFields.date: date,
        QuestFields.time: time,
        QuestFields.name_r: name_r
      };
}
