import 'package:flutter/material.dart';
import 'package:game_of_life/model/reward_model.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/widget/settings_list.dart';

class setting_page extends StatelessWidget {
  const setting_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2D2D),
      body:
          FutureBuilder<List<Reward>>(
            future: QuestsDatabase.instance.readAllRewards(),
            builder: (BuildContext context, AsyncSnapshot<List<Reward>> rewards){
              if (rewards.hasData) {
                return ListView.builder(
                    itemCount: rewards.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      Reward reward = rewards.data![index];
                      return RewardCardWidget(reward: reward, index: index);
                    });
              } else {
                return Text('Настройки грузятся');
              }
            },
          ),
    );
  }

}
