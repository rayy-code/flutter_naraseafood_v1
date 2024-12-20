import 'package:flutter/material.dart';

Widget sales(String totalSales,{required onClick})
{
  return Positioned(
    top: 220.0,
    bottom: 10.0,
    left: 20,
    child: Container(
      width: 350,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: (){
                onClick();
              },
              icon: const Icon(Icons.refresh),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Total Sales Today : ",
                    style: TextStyle(
                      fontSize: 10, 
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    totalSales,
                    style: const TextStyle(
                      fontSize: 16, 
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    ),
  );
}