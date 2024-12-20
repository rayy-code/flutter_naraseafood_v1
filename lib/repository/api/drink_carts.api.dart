import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naraseafood/model/drink_cart.dart';


class DrinkCartsApi {

  //menambahkan ke cart
  static Future<bool> addToCart(String uuid, String idDrink, int qty, int totalPrice) async
  {
    //mendefinisikan endpoint API
    const String url = "https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/drink_carts";

    //mendefinisikan headers http
    final headers = {
      'Content-Type': 'application/json',
    };

    //mendefinisikan data yang akan dikirim
    final body = jsonEncode({
      "idDrinkCart": uuid,
      "idDrink": idDrink,
      "qty": qty,
      "totalPrice": totalPrice
    });

    try {
      //mengirim data ke server
      final response = await http.post(Uri.parse(url), body: body, headers: headers);
      if(response.statusCode == 200)
      {
        debugPrint("Data stored");
        return true;
      }else{
        return false;
      }
    } catch (e) {
      debugPrint("Error at : $e");
      return false;
    }
  }

  //mengambil data dari drink cart
  static Future<List<DrinkCart>> getDrinkCart(String idDrinkCart) async {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/drink_carts/$idDrinkCart");
    List lsQty = [];
    List drink = [];
    List lsTp = [];
    try {
      final response = await http.get(url);
      if(response.statusCode == 200)
      {
        final Map data = jsonDecode(response.body);
        for (var i in data['data']['drink_carts']) {
          drink.add(i['drink']);
          lsQty.add(i['qty']);
          lsTp.add(i['totalPrice']);
        }
        for (var i = 0; i < drink.length; i++) {
          drink[i]['qty'] = lsQty[i];
          drink[i]['idDrinkCart'] = idDrinkCart;
          drink[i]['price'] = lsTp[i];

        }
      }
    } catch (e) {
      debugPrint("Error at : $e");
    }
    debugPrint("$drink");
    return DrinkCart.cartFromSnapshot(drink);


  }

  static Future<bool> destroy(String idDrinkCart, String idDrink) async 
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/drink-cart/d/$idDrinkCart/$idDrink");

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