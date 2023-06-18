import 'package:flutter/material.dart';


class stats_page extends StatelessWidget {
  const stats_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Center(child: Text("Тут может быть отчет",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ));
  }
}
