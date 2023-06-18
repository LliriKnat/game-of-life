import 'package:flutter/material.dart';

class map_page extends StatelessWidget {
  const map_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Соберем эту страницу через центр
    //При этмо оберем ее в column and rows
    return const Center(child: Text("Тут может быть карта",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ));
  }
}