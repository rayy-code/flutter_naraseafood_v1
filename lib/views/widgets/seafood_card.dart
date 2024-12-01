import 'package:flutter/material.dart';

class SeafoodCard extends StatelessWidget{
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  const SeafoodCard({
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
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white10,
                      spreadRadius: -5.0,
                      offset: Offset(0.0,20.0),
                      blurRadius: 10.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(strMealThumb),
                      fit: BoxFit.cover
                    )
                  ),
              ),
              const SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                      strMeal,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        overflow: TextOverflow.visible,
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
              ),
              ElevatedButton(
                clipBehavior: Clip.hardEdge,
                style: ButtonStyle(
                  
                ),
                onPressed: (){

                },
                child: const Text("Order"),
              )
            ]
          )
        ),
      ),
    );
  }
}