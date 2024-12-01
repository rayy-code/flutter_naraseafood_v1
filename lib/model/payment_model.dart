import 'dart:convert';

class PaymentModel {

  final int? id;
  final int idPayment;
  final int idOrder;
  final int totalPrice;
  final int pay;
  final int excessMoney;

  PaymentModel({
    this.id,
    required this.idPayment,
    required this.idOrder,
    required this.totalPrice,
    required this.pay,
    required this.excessMoney,
  });

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'idPayment': idPayment,
      'idOrder': idOrder,
      'totalPrice': totalPrice,
      'pay': pay,
      'excessMoney': excessMoney
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map)
  {
    return PaymentModel(
      id: map['id']?.toInt(),
      idPayment: map['idPayment']?.toInt(),
      idOrder: map['idOrder']?.toInt(),
      totalPrice: map['totalPrice']?.toInt(),
      pay: map['pay']?.toInt(),
      excessMoney: map['excessMoney']?.toInt(),
    );
  }

  String toJson()=> json.encode(toMap());
}