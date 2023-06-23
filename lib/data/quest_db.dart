import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:game_of_life/model/quest_model.dart';
import 'package:game_of_life/model/quest_log.dart';
import 'package:game_of_life/model/reward_model.dart';
import 'package:game_of_life/model/inventory_model.dart';
import 'package:game_of_life/model/person_model.dart';


class QuestsDatabase {
  static final QuestsDatabase instance = QuestsDatabase._init();
  static Database? _database;
  QuestsDatabase._init();
  static bool kDebugMode = true;


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quest.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    if (kDebugMode) {
      print('db location: $dbPath');
    }
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER';
    const nameType = 'VARCHAR(15) NOT NULL';
    const sumType = 'VARCHAR(255) NOT NULL';
    const textType = 'TEXT NOT NULL';
    const placeType = 'VARCHAR(100)';

    /// CREATE TABLE tableQuest
    await db.execute('''
    CREATE TABLE $tableQuests (
    ${QuestFields.id} $idType,
    ${QuestFields.name} $nameType,
    ${QuestFields.summary} $sumType,
    ${QuestFields.difficulty} $integerType,
    ${QuestFields.estimated_duration} $integerType,
    ${QuestFields.place} $placeType,
    ${QuestFields.status} $nameType,
    ${QuestFields.date} $textType,
    ${QuestFields.time} $textType,
    ${QuestFields.name_r} $nameType      
    )
    ''');
    /// CREATE TABLE tablePerson
    await db.execute('''
      CREATE TABLE $tablePerson (
      ${PersonFields.id} $idType,
      ${PersonFields.name} $nameType,
      ${PersonFields.stamina} $integerType,
      ${PersonFields.exp} $integerType   
      )
    ''');
    /// CREATE TABLE tableReward
    await db.execute('''
      CREATE TABLE $tableReward (
      ${RewardFields.id} $idType,
      ${RewardFields.name_r} $nameType,
      ${RewardFields.coeff} $integerType
      )
    ''');
    /// CREATE TABLE tableInventory
    await db.execute('''
      CREATE TABLE $tableInventory (
      ${InventoryFields.id} $idType,
      ${InventoryFields.id_reward} $integerType,
      ${InventoryFields.id_person} $integerType,
      ${InventoryFields.count} $integerType
      )
    ''');

    // Костыльное добавление наград
    await db.rawInsert(
        '''INSERT INTO $tablePerson (${PersonFields.name}, ${PersonFields.stamina}, ${PersonFields.exp}) VALUES ('Player', 100, 10)''');

    await db.rawInsert(
        '''INSERT INTO $tableReward (${RewardFields.name_r}, ${RewardFields.coeff}) VALUES ('Посмотреть ютубчик', 30)''');
    await db.rawInsert(
        '''INSERT INTO $tableReward (${RewardFields.name_r}, ${RewardFields.coeff}) VALUES ('Поиграть в игры', 30)''');
    await db.rawInsert(
        '''INSERT INTO $tableReward (${RewardFields.name_r}, ${RewardFields.coeff}) VALUES ('Купить вкусняшку', 1)''');
    await db.rawInsert(
        '''INSERT INTO $tableReward (${RewardFields.name_r}, ${RewardFields.coeff}) VALUES ('Погулять', 1)''');
    await db.rawInsert(
        '''INSERT INTO $tableReward (${RewardFields.name_r}, ${RewardFields.coeff}) VALUES ('Поспать', 4)''');

    await db.rawInsert(
        '''INSERT INTO $tableInventory (${InventoryFields.id_reward}, ${InventoryFields.id_person}, ${InventoryFields.count}) VALUES (0, 0, 0)''');
    await db.rawInsert(
        '''INSERT INTO $tableInventory (${InventoryFields.id_reward}, ${InventoryFields.id_person}, ${InventoryFields.count}) VALUES (1, 0, 0)''');
    await db.rawInsert(
        '''INSERT INTO $tableInventory (${InventoryFields.id_reward}, ${InventoryFields.id_person}, ${InventoryFields.count}) VALUES (2, 0, 0)''');
    await db.rawInsert(
        '''INSERT INTO $tableInventory (${InventoryFields.id_reward}, ${InventoryFields.id_person}, ${InventoryFields.count}) VALUES (3, 0, 0)''');
    await db.rawInsert(
        '''INSERT INTO $tableInventory (${InventoryFields.id_reward}, ${InventoryFields.id_person}, ${InventoryFields.count}) VALUES (4, 0, 0)''');
  }

  // #################### Quest ##########################################

  Future<Quest> create(Quest quest) async {
    final db = await instance.database;
    final id = await db.insert(tableQuests, quest.toJson());
    return quest.copy(id: id);
  }

  // Получить квест по айди из баззы данных
  Future<Quest> readQuest(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableQuests,
      columns: QuestFields.values,
      where: '${QuestFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Quest.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  /// Находит первый квест в базе данных с заданным статусом
  Future<Quest> readNearestQuest(String status) async {
    final db = await instance.database;
    final orderBy = '${QuestFields.date} ASC';
    final maps = await db.query(
      tableQuests,
      columns: QuestFields.values,
      orderBy: orderBy,
      where: '${QuestFields.status} = ?',
      whereArgs: [status],
    );
    return Quest.fromJson(maps.first);
  }

  /// Находит все квесты с заданным статусом
  Future<List<Quest>> readAllQuests(String status) async {
    final db = await instance.database;
    final orderBy = '${QuestFields.date} ASC';
    final result = await db.query(tableQuests,
        orderBy: orderBy,
        where: '${QuestFields.status} = ?',
        whereArgs: [status]);
    return result.map((json) => Quest.fromJson(json)).toList();
  }

  /// обнавляет все поля квеста по айди
  Future<int> update(Quest quest) async {
    final db = await instance.database;
    return db.update(
      tableQuests,
      quest.toJson(),
      where: '${QuestFields.id} = ?',
      whereArgs: [quest.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableQuests,
      where: '${QuestFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  /// #################### Person ###############################################

  Future<Person> create_person(Person person) async {
    final db = await instance.database;
    final id = await db.insert(tablePerson, person.toJson());
    return person.copy(id: id);
  }

  Future<Person> readPerson(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update_person(Person person) async {
    final db = await instance.database;
    return db.update(
      tablePerson,
      person.toJson(),
      where: '${PersonFields.id} = ?',
      whereArgs: [person.id],
    );
  }

  /// ###################### Reward #############################################

  Future<Reward> create_reward(Reward reward) async {
    final db = await instance.database;
    final id = await db.insert(tablePerson, reward.toJson());
    return reward.copy(id: id);
  }

  Future<int> update_reward(Reward reward) async {
    final db = await instance.database;
    return db.update(
      tableReward,
      reward.toJson(),
      where: '${RewardFields.id} = ?',
      whereArgs: [reward.id],
    );
  }

  Future<List<Reward>> readAllRewards() async {
    final db = await instance.database;
    final orderBy = '${RewardFields.name_r} ASC';
    final result = await db.query(tableReward, orderBy: orderBy);
    return result.map((json) => Reward.fromJson(json)).toList();
  }

  // ####################### Inventory #########################################

  Future<List<Inventory>> readInventory(int idPerson) async {
    final db = await instance.database;
    const orderBy = '${InventoryFields.id_reward} ASC';
    final result = await db.query(
        tableInventory,
        orderBy: orderBy);
    return result.map((json) => Inventory.fromJson(json)).toList();
  }

  Future<Inventory> create_inventory(Inventory inventory) async {
    final db = await instance.database;
    final id = await db.insert(tablePerson, inventory.toJson());
    return inventory.copy(id: id);
  }

  Future<int>   update_inventory(Inventory inventory) async{
    final db = await instance.database;
    return db.update(
      tableInventory,
      inventory.toJson(),
      where: '${InventoryFields.id} = ?',
      whereArgs: [inventory.id],
    );
  }


  Future<int> delete_inventory(int id) async{
    final db = await instance.database;
    return await db.delete(
      tableInventory,
      where: '${InventoryFields.id} = ?',
      whereArgs: [id],
    );
  }

}
