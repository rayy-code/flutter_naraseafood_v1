import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentApi {



  static Future<int> addPayment(String idOrder, int totalPrice, int pay) async
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/payments");
    late Map data;
    final headers = {
      'Content-Type' : 'application/json'
    };

    final body = jsonEncode({
      'idOrder' : idOrder,
      'total_price' : totalPrice,
      'pay' : pay
    });

    try {
      final response = await http.post(url, body: body, headers: headers);
      if(response.statusCode == 200)
      {
        data = jsonDecode(response.body);
        
      }
    } catch (e) {
      debugPrint("Error at : $e");
      return 0;
    }

    return data['data']['excessMoney'];
  }

  static Future<int> getTotalSalesByDate(String date) async
  {
    final url = Uri.parse("https://fdd3-2001-448a-2002-3b6-8d60-dbc2-203e-9fda.ngrok-free.app/api/sales/$date");
    int total =0;
    List temp=[];
    try {
      final response = await http.get(url);
      if(response.statusCode == 200)
      {
        Map data = jsonDecode(response.body);
        for (var i in data['data']['sales']) {
          debugPrint("$i");
          //total += int.parse(i['total_price']);
          temp.add(i);
        }
        for (var i = 0; i < temp.length; i++) {
          total += temp[i]['total_price'] as int;
        }
      }
    } catch (e) {
      debugPrint("error at : $e");
      return 0;
    }
    debugPrint("total : $total");
    return total;
  }

}