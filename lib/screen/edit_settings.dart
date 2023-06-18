import 'package:flutter/material.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/widget/settings_list.dart';
import 'package:game_of_life/model/reward_model.dart';

class edit_settings extends StatefulWidget {
  final Reward? reward;
  const edit_settings({
    Key? key,
    this.reward,

  }) : super(key: key);
  @override
  _edit_settingsPageState createState() => _edit_settingsPageState();
}

class _edit_settingsPageState extends State<edit_settings> {
  final _formKey = GlobalKey<FormState>();
  late String name_r;
  late int coeff;

  @override
  void initState() {
    super.initState();
    name_r = widget.reward?.name_r ?? '';
    coeff = widget.reward?.coeff ?? 0;
  }

  @override build(BuildContext context) => Scaffold(
    // body: ListView.builder(
        // itemCount: 5,
        // itemBuilder: (BuildContext context, int index){
        //   Reward reward = context;
        //   return RewardCardWidget(reward: reward, index: index);}
    // )
    );


  Future updateQuest() async {
    final reward = widget.reward!.copy(
      name_r: name_r,
      coeff: coeff,
      );
    await QuestsDatabase.instance.update_reward(reward);
}
}