import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naraseafood/model/meals.dart';
class MealsApi {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final int price;

  MealsApi({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.price
  });

  static Future<List<Meals>> getMeals() async
  {
    List _temp = [];
    try {
      final response = await http.get(Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/meals"));
      if(response.statusCode == 200){
        Map data = jsonDecode(response.body);
        for (var i in data['data']['meals']) {
          _temp.add(i);
        }
      }else{
        debugPrint("${response.statusCode}");
      }
      
    } catch (e) {
      debugPrint("Error at: $e");
    }
    debugPrint("$_temp");
    return Meals.mealsFromSnapshot(_temp);
  }
}