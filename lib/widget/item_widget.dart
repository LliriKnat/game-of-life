import 'package:flutter/material.dart';
import 'package:game_of_life/model/inventory_model.dart';
import '../data/quest_db.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({
  Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Inventory item;
  final int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton.icon(
        // padding: EdgeInsets.zero,
        onPressed:
            () async {
          print(item_counts);
          var new_count = this.item.count-item_counts[this.item.id!.toInt()-1];
          if (new_count < 0){
            new_count = 0;
          }
          final item = this.item.copy(count: new_count);
          await QuestsDatabase.instance.update_inventory(item);
        },
        icon: const ImageIcon(AssetImage("assets/WMP_normal.png"),
            color: Colors.blue, size: 40,),
        label: Text('${item.count}'),
      );
  }

  static List<int> item_counts = <int>[1, 30, 30, 1, 4];

}

