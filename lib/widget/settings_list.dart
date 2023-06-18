
import 'package:flutter/material.dart';
import 'package:game_of_life/model/reward_model.dart';
import 'package:game_of_life/data/quest_db.dart';

class RewardCardWidget extends StatelessWidget {
  RewardCardWidget({
    Key? key,
    required this.reward,
    required this.index,

  }) : super(key: key);

  final Reward reward;
  final int index;
  @override
  Widget build(BuildContext context){
    final color = Color(0xff2D2D2D);
    final name_r = reward.name_r;
    final coeff = reward.coeff;
    return Card(
      color: color,
      child: Container(
          child: Row(children: [Text(name_r), Spacer(), buildCoeff(coeff, name_r)],),
      ),
    );
  }

  Widget buildCoeff(coeff, name_r) => TextFormField(
      style:  TextStyle( color: Colors.white,),
      initialValue: "$coeff",
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: 40),),
    // onEditingComplete: () async {final reward = Reward(name_r: name_r, coeff: coeff); await QuestsDatabase.instance.update_reward(reward);},
  );
  // void updateReward() async{
  //   final reward = Reward(name_r: name_r, coeff: coeff);
  //   await QuestsDatabase.instance.update_reward(reward);
  // }
}
