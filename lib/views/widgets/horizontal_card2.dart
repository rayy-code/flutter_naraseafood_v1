import 'package:flutter/material.dart';

class HorizontalCard2 extends StatelessWidget{
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final double price;
  final toDo;

  const HorizontalCard2({
    super.key,
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.price,
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
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(strMealThumb),
                      fit: BoxFit.cover,
                    )
                  )
                ),
              ),
              const SizedBox(width: 5.0,),
              Expanded(
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        strMeal,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                       
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                          "Rp. $price",
                          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  icon: const Icon(Icons.money_off_csred_rounded),
                  onPressed: () {
                    toDo();
                  },
                  label: const Text("Order"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}