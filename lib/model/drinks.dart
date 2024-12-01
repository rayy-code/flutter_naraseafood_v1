class Drinks {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  Drinks({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
  });

  Map<String, dynamic> toMap(){
    return {
      'idDrink': idDrink,
      'strDrink' : strDrink,
      'strDrinkThumb' : strDrinkThumb,
    };
  }

  factory Drinks.fromMap(dynamic json)
  {
    return Drinks(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );
  }

  static List<Drinks> drinksFromSnapshot(List snapshot)
  {
    return snapshot.map((data){
      return Drinks.fromMap(data);
    }).toList();
  }

  @override
  String toString()
  {
    return 'Drinks : {idDrink : $idDrink, strDrink : $strDrink, strDrinkThumb : $strDrinkThumb}' ;
  }

}