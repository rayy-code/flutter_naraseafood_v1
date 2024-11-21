import 'package:flutter/material.dart';
import 'package:naraseafood/model/meals.dart';
import 'package:naraseafood/repository/api/seafood_meals.api.dart';
import 'package:naraseafood/views/widgets/card_food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final TextEditingController strMealController = TextEditingController();

  late List<Meals> mealsList;
  bool _isLoading = true;

  @override
  void initState()
  {
    super.initState();
    getMeals();
  }

  Future<void> getMeals() async {
    mealsList = await SeafoodMealsApi.getMeals();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 25.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SearchBar(
                    hintText: 'Nama Makanan',
                    onChanged: (value) {

                    },
                    leading: const Icon(Icons.search),
                    controller: strMealController,
                  ),
                ),
                
                const SizedBox(height: 25),
                const Text(
                  "Daftar Makanan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 15.0,),
                _isLoading ? const Center(
                  child: CircularProgressIndicator(), 
                  
                ) :
                Expanded(
                  
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: mealsList.length,
                    itemBuilder: (context, index) => CardFood(
                      strMeal: mealsList[index].strMeal,
                      idMeal: mealsList[index].idMeal,
                      strMealThumb: mealsList[index].strMealThumb,
                    ),
                  ),
                )
              ],
            )
    );
  }
}
