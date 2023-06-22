import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:game_of_life/data/quest_db.dart';
import 'package:game_of_life/model/inventory_model.dart';
import 'package:game_of_life/model/quest_model.dart';
import 'package:game_of_life/screen/text_api/text_api.dart';
import 'package:game_of_life/screen/text_api/text_model.dart';
import 'package:game_of_life/widget/current_quest_card.dart';

import '../widget/item_widget.dart';
import '../widget/quest_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Quotes? data;

  Future<Null> getQuotes() async {
    data = await Api.getQuotes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {

    void Function() pressedInventory(Inventory item) {
      void f(){
        print(item.id);
      }
      return f;
    }

    Widget EmptyList() => Text('Пока наград нет');

    /// Соберем эту страницу через центр
    /// При этом соберем ее в column and rows
    return Scaffold(

        backgroundColor: Color(0xff2D2D2D),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Container(
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color(0xff2D2D2D), boxShadow: [
              BoxShadow(
                color: Color(0xff4D000000),
                spreadRadius: 11,
                blurRadius: 4,
                offset: Offset(0, 4),
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Иконка пользователя с его именем
                  BlurryContainer(
                      padding: const EdgeInsets.all(1),
                      borderRadius: const BorderRadius.all(Radius.circular(1)),
                      width: 175,
                      height: 50,
                      color: const Color(0xff4180BA).withOpacity(0.6),
                      blur: 6,

                      child: Container(
                        width: 170,
                        height: 45,
                        color: const Color(0xff4180BA),
                        child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: ImageIcon(AssetImage("assets/info.png"),
                                    size: 28.0, color: Colors.white),
                              ),
                              Text('Player', style: TextStyle(fontSize: 18))
                            ]),
                      )),
                  // Полосы здоровья и опыта
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text('Life'),
                      ),
                      // Полоска здоровья
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: Container(
                          width: 150,
                          height: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xff818181)),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text('Exp'),
                      ),
                      // Полоска опыта
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Container(
                          width: 150,
                          height: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xff818181)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// надпись над текущим заданием
              const Text(
                'Текущее задание',
                textAlign: TextAlign.left,
              ),

              /// текущее задание
              FutureBuilder(
                  future: QuestsDatabase.instance.readNearestQuest('Принято'),
                  builder: (BuildContext context, AsyncSnapshot<Quest> quests) {
                    if (quests.hasData) {
                      Quest name = quests.data!;
                      return CurrentQuestCard(quest: name);
                    } else {
                      return const Text('Нет подобранных заданий');
                    }
                  }),

              /// основная часть
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/default.png",
                      color: Colors.white,
                      fit: BoxFit.fitWidth,
                      alignment: AlignmentDirectional.center,

                    ),
                    const Spacer(),

                    Column(children: [
                      /// блок цитатника

                      GestureDetector(
                        onTap: () {
                          //print("Click event on Container");
                          getQuotes();
                        },
                        child: Container(
                          width: 200,
                          height: 155,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: const Color(0xff818181),
                              ),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                data?.content ?? "Keep on tapping, baby!.",
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),


                      /// Инвентарь
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: 200,
                            height: 175,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: const Color(0xff818181),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: FutureBuilder<List<Inventory>>(
                              future: QuestsDatabase.instance.readInventory(0),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Inventory>> inventory) {
                                if (inventory.hasData) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 100,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0),
                                    itemCount: inventory.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Inventory item = inventory.data![index];
                                      const rewardItems = <String>[
                                        'Посмотреть ютубчик',
                                        'Поиграть в игры',
                                        'Купить вкусняшку',
                                        'Погулять',
                                        'Поспать'
                                      ];
                                      var func = pressedInventory(item);
                                      return ItemWidget(item: item, index: index);
                                    },
                                  );
                                } else {
                                  return EmptyList();
                                }
                              },
                            ),
                          )),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
