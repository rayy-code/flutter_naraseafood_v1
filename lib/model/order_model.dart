import 'dart:convert';

class OrderModel {

  final int? id;
  final int idOrder;
  final int? idMealCart;
  final int? idDrinkCart;
  final int totalPrice;

  OrderModel({
    this.id,
    required this.idOrder,
    this.idMealCart,
    this.idDrinkCart,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'idOrder' : idOrder,
      'idMealCart' : idMealCart,
      'idDrinkCart' : idDrinkCart,
      'totalPrice' : totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map)
  {
    return OrderModel(
      id: map['id']?.toInt(),
      idOrder: map['idOrder']?.toInt(),
      idMealCart: map['idMealCart']?.toInt(),
      idDrinkCart: map['idDrinkCart']?.toInt(),
      totalPrice: map['totalPrice']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

}