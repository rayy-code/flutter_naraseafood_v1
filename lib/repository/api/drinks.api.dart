import 'dart:convert';

import 'package:naraseafood/model/drinks.dart';
import 'package:http/http.dart' as http;

class DrinksApi {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  DrinksApi({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
  });

  static Future<List<Drinks>> getDrinks() async 
  {
    final response = await http.get(Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/drinks"));

    Map data = jsonDecode(response.body);
    List temp = [];
    for(var i in data['data']['drinks'])
    {
      temp.add(i);
    }
    return Drinks.drinksFromSnapshot(temp);
  }
}