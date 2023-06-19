final String tablePerson = 'person';

class PersonFields {
  static final List<String> values = [id, name, stamina, exp];
  static const String id = '_id';
  static const String name = 'name';
  static const String stamina = 'stamina';
  static const String exp = 'exp';
}

class Person {
  final int? id;
  final String name;
  final int stamina;
  final int exp;

  const Person(
      {this.id, required this.name, required this.stamina, required this.exp});

  Person copy({
    int? id,
    String? name,
    int? stamina,
    int? exp,
  }) =>
      Person(
          id: id ?? this.id,
          name: name ?? this.name,
          stamina: stamina ?? this.stamina,
          exp: exp ?? this.exp);
  static Person fromJson(Map<String, Object?> json) => Person(
        id: json[PersonFields.id] as int?,
        name: json[PersonFields.name] as String,
        stamina: json[PersonFields.stamina] as int,
        exp: json[PersonFields.exp] as int,
      );
  Map<String, Object?> toJson() => {
        PersonFields.id: id,
        PersonFields.name: name,
        PersonFields.stamina: stamina,
        PersonFields.exp: exp
      };
}
