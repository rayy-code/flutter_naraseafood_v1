import 'dart:convert';

class Cart {
  final int? id;
  final int idCart;
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final int qty;
  final int price;

  Cart({
    this.id,
    required this.idCart,
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'idCart': idCart,
      'idMeal': idMeal,
      ' strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'qty': qty,
      'price': price,
    };
  }

  factory Cart.fromMap(Map<String, dynamic>map){
    return Cart(
      id: map['id']?.toInt(),
      idCart: map['idCart']?.toInt(),
      idMeal: map['idMeal'],
      strMeal: map['strMeal'],
      strMealThumb: map['strMealThumb'],
      qty: map['qty']?.toInt(),
      price: map['price']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source)=>
    Cart.fromMap(json.decode(source));

  Cart copyWith({
    int? id,
    int? idCart,
    String? idMeal,
    String? strMeal,
    String? strMealThumb,
    int? qty,
    int? price,
  }){
    return Cart(
      id: id ?? this.id,
      idCart: idCart ?? this.idCart,
      idMeal: idMeal ?? this.idMeal,
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }
}