import 'package:flutter/material.dart';

class HorizontalCardfood extends StatelessWidget{
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final double mealPrice;
  final toDo;


  const HorizontalCardfood({
    super.key,
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.mealPrice,
    required this.toDo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                width: 380,
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //gambar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(strMealThumb),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    //nama makanan
                    const SizedBox(width: 5.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            strMeal,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: true,
                          ),
                        ),
                      
                        const SizedBox(height: 5.0),
                        Text(
                          "Rp. $mealPrice",
                          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                    
                  ]
                ),
              ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.money_off_csred_rounded),
                onPressed: () {
                  toDo();
                },
                label: const Text("Order"),
              )
            ]
          ),
        ),
      ),
    );
  }
}