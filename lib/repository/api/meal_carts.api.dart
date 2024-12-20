import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naraseafood/model/cart.dart';


class MealCartsApi {


  //menambahkan ke cart
  static Future<bool> addToCart(String uuid, String idMeal, int qty, int totalPrice) async
  {
    const String url = "https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/meal_carts";
    //final request = http.MultipartRequest('POST',Uri.parse(url));

    //request.fields['idMeal'] = idMeal;
    //request.fields['qty'] = "$qty";
    final headers = {
      'Content-Type' : "application/json",
    };
    final body = jsonEncode({
      'idMealCart' : uuid,
      'idMeal' : idMeal,
      'qty' : qty,
      'totalPrice' : totalPrice
    });

    try {
      final response = await http.post(Uri.parse(url), body: body, headers: headers);
      if(response.statusCode == 200){
        debugPrint("data stored");
      }
    } catch (e) {
      debugPrint("Error at : $e");
      return false;
    }
    return true;
  }

  //mengambil data dari cart
  static Future<List<Cart>> getCartById(String idMealCart) async {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/meal_carts/$idMealCart");
    List lsQty = [];
    List _temp = [];
    List lsTp = [];
    //List combine = [];
    try {
      final response = await http.get(url);
      if(response.statusCode == 200){
        final Map data = jsonDecode(response.body);
        for (var i in data['data']['meal_carts']) {
          _temp.add(i['meal']);
          lsQty.add(i['qty']);
          lsTp.add(i['totalPrice']);
        }
        for (var i =0; i < _temp.length ; i++) {
          _temp[i]['qty'] = lsQty[i]; 
          _temp[i]['idMealCart'] = idMealCart;
          _temp[i]['price'] = lsTp[i];
        }
        
      }

    } catch (e) {
     debugPrint('Error at : $e');
    }
    
    return Cart.mealsFromSnapshot(_temp);
  }

  static Future<bool> destroy(String idMealCart, String idMeal) async 
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/meal-cart/d/$idMealCart/$idMeal");

    try {
      final response = await http.delete(url);

      if(response.statusCode == 200)
      {
        return true;
      }else{
        return false;
      }
      
    } catch (e) {
      debugPrint("Error at : $e");
      return false;
    }
  }
}