
class Meals {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;


  Meals({

    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,

  });

  Map<String, dynamic> toMap()
  {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,

    };
  }

  factory Meals.fromMap(dynamic json)
  {
    return Meals(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,

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
    return 'Meals : {idMeal : $idMeal, strMeal : $strMeal, strMealThumb : $strMealThumb}';
  }


}