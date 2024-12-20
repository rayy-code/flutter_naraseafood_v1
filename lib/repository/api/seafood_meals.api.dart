import 'dart:convert';

import 'package:naraseafood/model/meals.dart';
import 'package:http/http.dart' as http;

class SeafoodMealsApi {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  SeafoodMealsApi({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  static Future<List<Meals>> getMeals() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'));

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['meals']) {
      _temp.add(i);
    }
    return Meals.mealsFromSnapshot(_temp);
  }

  //mengirim data dengan POST
  // static Future<void> postMeals(Meals meals) async {
  //   final response = await http.post(Uri.parse('https://www.themealdb.com/api/json/v'));
  // }
}