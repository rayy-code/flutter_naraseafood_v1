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
    final response = await http.get(Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"));

    Map data = jsonDecode(response.body);
    List temp = [];
    for(var i in data['drinks'])
    {
      temp.add(i);
    }
    return Drinks.drinksFromSnapshot(temp);
  }
}