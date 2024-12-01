import 'dart:convert';

class DrinkCart {
  final int? id;
  final int idDrinkCart;
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final int qty;
  final int price;

  DrinkCart({
    this.id,
    required this.idDrinkCart,
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'idDrinkCart' : idDrinkCart,
      'idDrink' : idDrink,
      'strDrink' : strDrink,
      'strDrinkThumb' : strDrinkThumb,
      'qty' : qty,
      'price' : price
    };
  }

  factory DrinkCart.fromMap(Map<String, dynamic> map)
  {
    return DrinkCart(
      id: map['id']?.toInt(),
      idDrinkCart: map['idDrinkCart']?.toInt(),
      idDrink: map['idDrink'],
      strDrink: map['strDrink'],
      strDrinkThumb: map['strDrinkThumb'],
      qty: map['qty']?.toInt(),
      price: map['price']?.toInt(),
    );
  }

  String toJson()=> json.encode(toMap());

}