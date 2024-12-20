import 'package:flutter/material.dart';

Widget headerDashboard(username, role)
{
  return Container(
    height: 300.0,
    width: double.infinity,
    decoration: const BoxDecoration(
      // gradient: LinearGradient(
      //   colors: [Color.fromARGB(255, 106, 205, 250), Colors.lightBlue],
      //   stops: [0.1, 0.9],
      //   begin: Alignment.topCenter,
      // ),
      
    ),
    child: Container(
      height: 240.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50.0),
        bottomRight: Radius.circular(50.0),
        )
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: const DecorationImage(
                  image: NetworkImage("https://www.iconarchive.com/download/i113145/fa-team/fontawesome/FontAwesome-User.1024.png",scale: 1.0),
                  fit: BoxFit.cover
                )
              ),
            ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$username",
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "$role",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ]
          ),
        ]
      )
    ),
    )
  );
}