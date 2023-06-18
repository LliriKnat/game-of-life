const String tableInventory = 'inventory';

class InventoryFields {
  static final List<String> values = [id, id_reward, id_person, count];
  static const String id = '_id';
  static const String id_reward = 'id_reward';
  static const String id_person = 'id_person';
  static const String count = 'cout';
}

class Inventory {
  final int? id;
  final int id_reward;
  final int id_person;
  final int count;

  const Inventory(
      {this.id,
      required this.id_reward,
      required this.id_person,
      required this.count});

  Inventory copy({
    final int? id,
    final int? id_reward,
    final int? id_person,
    final int? count,
  }) =>
      Inventory(
          id: id ?? this.id,
          id_reward: id_reward ?? this.id_reward,
          id_person: id_person ?? this.id_person,
          count: count ?? this.count);


  static Inventory fromJson(Map<String, Object?> json) => Inventory(
    id: json[InventoryFields.id] as int?,
    id_reward: json[InventoryFields.id_reward] as int,
    id_person: json[InventoryFields.id_person] as int,
    count: json[InventoryFields.count] as int
  );

  Map<String, Object?> toJson() => {
    InventoryFields.id: id,
    InventoryFields.id_reward: id_reward,
    InventoryFields.id_person: id_person,
    InventoryFields.count: count
  };
}
