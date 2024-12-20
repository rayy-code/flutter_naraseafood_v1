import 'dart:convert';

class DrinkCart {

  final String idDrinkCart;
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final int qty;
  final int price;

  DrinkCart({

    required this.idDrinkCart,
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
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

      idDrinkCart: map['idDrinkCart']as String,
      idDrink: map['idDrink'] as String,
      strDrink: map['strDrink'] as String,
      strDrinkThumb: map['strDrinkThumb'] as String,
      qty: map['qty']?.toInt(),
      price: map['price']?.toInt(),
    );
  }

  String toJson()=> json.encode(toMap());

  static List<DrinkCart> cartFromSnapshot(List snapshot)
  {
    return snapshot.map((data){
      return DrinkCart.fromMap(data);
    }).toList();
  }

}