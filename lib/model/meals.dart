
class Meals {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final int price;


  Meals({

    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.price,
  });

  Map<String, dynamic> toMap()
  {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'price': price
    };
  }

  factory Meals.fromMap(dynamic json)
  {
    return Meals(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      price: json['price'] as int

    );
  }

  static List<Meals> mealsFromSnapshot(List snapshot)
  {
    return snapshot.map((data){
      return Meals.fromMap(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Meals : {idMeal : $idMeal, strMeal : $strMeal, strMealThumb : $strMealThumb, price : $price}';
  }


}