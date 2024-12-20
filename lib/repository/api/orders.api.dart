import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class OrdersApi{


  static Future<bool> addToOrder(String idOrder, String idMealCart, String idDrinkCart) async
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/orders");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      'idOrder' : idOrder,
      "idMealCart" : idMealCart,
      "idDrinkCart" : idDrinkCart
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200)
      {
        debugPrint("Data stored");
        return true;
      }else{
        debugPrint("Error");
        return false;
      }
    } catch (e) {
      debugPrint("Error at : $e");
      
      return false;
    }
  }

  static Future<Map<String, dynamic>> getDataOrder(String idOrder) async
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/orders/$idOrder");
    Map<String, dynamic> data = {};

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint("error at : $e");
    }
  debugPrint("Data : $data");
    return data;
  }
}