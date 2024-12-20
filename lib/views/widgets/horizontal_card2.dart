import 'package:flutter/material.dart';
import 'package:naraseafood/helper/format_string.dart';

class HorizontalCard2 extends StatelessWidget{
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final int price;
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
                      image: NetworkImage(strMealThumb, scale: 1.0),
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
                          FormatString.toRupiah(price),
                          style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                    )
                  ],
                ),
              ),
              IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                     foregroundColor: MaterialStateProperty.all(Colors.white)
                   ),
                  onPressed: (){
                    toDo();
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                )
            ],
          ),
        ),
      ),
    );
  }
}
// ElevatedButton.icon(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
//                     foregroundColor: MaterialStateProperty.all(Colors.white)
//                   ),
//                   icon: const Icon(Icons.add_shopping_cart_rounded),
//                   onPressed: () {
//                     toDo();
//                   },
//                   label: const Text("Order"),
//                 ),