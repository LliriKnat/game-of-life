import 'dart:convert';

import 'package:http/http.dart' as http;

import 'text_model.dart';

class Api {
  static Future<Quotes> getQuotes() async {
    Uri url = Uri.parse('https://api.quotable.io/random?maxLength=40');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print("success");
      return Quotes.fromJson(jsonDecode(response.body));
    } else {
      print("error in getting data");
      return Quotes(id:"aaaa",
          content:"Если мечты не пугают, то они слишком малы.",
          author:"Obama?",
          tags:["Friendship"],
          authorSlug:"emily-dickinson",
          length:30);
      }
  }
}