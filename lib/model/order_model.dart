import 'dart:convert';

class OrderModel {

  final String idOrder;
  final String? idMealCart;
  final String? idDrinkCart;
  final int totalPrice;

  OrderModel({

    required this.idOrder,
    this.idMealCart,
    this.idDrinkCart,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap()
  {
    return {

      'idOrder' : idOrder,
      'idMealCart' : idMealCart,
      'idDrinkCart' : idDrinkCart,
      'totalPrice' : totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map)
  {
    return OrderModel(

      idOrder: map['idOrder'] as String,
      idMealCart: map['idMealCart'] as String,
      idDrinkCart: map['idDrinkCart']as String,
      totalPrice: map['totalPrice']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  static List<OrderModel> orderFromSnapshot(List snapshot)
  {
    return snapshot.map((data){
      return OrderModel.fromMap(data);
    }).toList();
  }
}