import 'package:flutter/material.dart';
import 'package:naraseafood/views/drink_page.dart';
import 'package:naraseafood/views/home.dart';
import 'package:naraseafood/views/widgets/card_icon.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{


  void goToPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return const HomePage();
      }));
  }

  void toDrinkPage()
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DrinkPage()
    ));
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('images/profile_2.png')),
            SizedBox(width: 5.0,),
            //Icon(Icons.food_bank),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Hi, Rayyanda', style: TextStyle(
                  fontSize: 12,
                ),),
                Text('@rayyanda5113', style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),),
              ],
            )
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.archive_outlined), onPressed: (){}),
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
        ]
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          CardIcon(
            cardIcon: const Icon(Icons.add_chart, size: 50.0, color: Colors.blueAccent,),
            title: 'New Order',
            toDo: (){
              goToPage();
            },
            ),
          CardIcon(
            cardIcon: const Icon(Icons.no_drinks_outlined, size: 50.0, color: Colors.blueAccent,),
            title: 'Drinks',
            toDo: (){
              toDrinkPage();
            },
          ),
          CardIcon(
            cardIcon: const Icon(Icons.settings, size: 50.0, color: Colors.blueAccent,),
            title: 'Settings',
            toDo: (){
              
            },
            ),
          CardIcon(
            cardIcon: const Icon(Icons.info_outline, size: 50.0, color: Colors.blueAccent,),
            title: 'Tentang Aplikasi',
            toDo: (){
             
            },
          ),
        ],
      )
    );
  }
}