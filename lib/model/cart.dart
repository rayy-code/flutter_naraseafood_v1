import 'dart:convert';

class Cart {

  final String idMealCart;
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final int qty;
  final int price;

  Cart({

    required this.idMealCart,
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap()
  {
    return {
  
      'idCart': idMealCart,
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'qty': qty,
      'price': price,
    };
  }

  factory Cart.fromMap(Map<String, dynamic>map){
    return Cart(

      idMealCart: map['idMealCart'] as String,
      idMeal: map['idMeal'] as String,
      strMeal: map['strMeal'] as String,
      strMealThumb: map['strMealThumb'] as String,
      qty: map['qty'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source)=>
    Cart.fromMap(json.decode(source));

  Cart copyWith({
    
    String? idMealCart,
    String? idMeal,
    String? strMeal,
    String? strMealThumb,
    int? qty,
    int? price,
  }){
    return Cart(
      idMealCart: idMealCart ?? this.idMealCart,
      idMeal: idMeal ?? this.idMeal,
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }

  static List<Cart> mealsFromSnapshot(List snapshot)
  {
    return snapshot.map((data){
      return Cart.fromMap(data);
    }).toList();
  }

}