import 'package:flutter/material.dart';


class CardIcon extends StatelessWidget{
  final Icon cardIcon;
  final String title;
  final toDo;

  const CardIcon({
    super.key,
    required this.cardIcon,
    required this.title,
    required this.toDo,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: InkWell(
          onTap: () {
            // Handle tap event
           toDo();
          },
          child: SizedBox(
            width: 150,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cardIcon,
                    const SizedBox(height: 5.0),
                    Text(title,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                    )
                  ]
                ),
              )
            ),
          )
        )
      ),
    );
  }
}