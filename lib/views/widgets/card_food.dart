import 'package:flutter/material.dart';

class CardFood extends StatelessWidget{

  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  const CardFood({
    super.key,
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(strMealThumb),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                      strMeal,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ),
                    const Text(
                      "Rp. 50.000",
                      style: TextStyle(
                        fontSize: 14.0,
                      )
                    )
                  ],
                )
          ],
        ),
      )
    );
  }
}