import 'package:flutter/material.dart';
import 'package:naraseafood/model/cart.dart';
import 'package:naraseafood/model/meals.dart';
import 'package:naraseafood/repository/api/init_api.dart';
import 'package:naraseafood/repository/api/meal_carts.api.dart';
import 'package:naraseafood/repository/api/meals.api.dart';
import 'package:naraseafood/repository/data/cart_local.dart';
import 'package:naraseafood/views/drink_page.dart';
import 'package:naraseafood/views/loading.dart';

import 'package:naraseafood/views/widgets/horizontal_card2.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final TextEditingController strMealController = TextEditingController();
  int idOrder = 0;
  int countOrdered = 0;
  int totalPrice = 0;
  late List<Cart> cartList = [];
  late List<Meals> mealsList;
  bool _isLoading = true;
  final mealRepo = CartLocal();
  late String idMealOrder ;

  @override
  void initState()
  {
    super.initState();
    getMeals();
    setUuid();
    //setId();
  }

  void setUuid() async {
    var id = const Uuid().v4();
    setState(() {
      idMealOrder = id;
    });
  }

  void setId ()async {
   
    int lastId = await mealRepo.getMaxId();
    setState(() {
      idOrder = lastId +=1;
    });
  }
 
  //membuat fungsi untuk menambahkan ke cart yang disimpan dalam sqlite
  // void addToCart(idOrder, idMeal, strMeal, strMealThumb, qty, price) async
  // {
  //   //mengecek apakah sudah dimasukkan kedalam order atau blum
  //   bool result = await mealRepo.checkIdCartAndMeal(idOrder, idMeal);

  // if (result == false) {
  //   // Jika belum ada, tambahkan item ke cart
    
  //   await mealRepo.addCart(
  //     Cart(
  //       idCart: idOrder,
  //       idMeal: idMeal,
  //       strMeal: strMeal,
  //       strMealThumb: strMealThumb,
  //       qty: qty,
  //       price: price,
  //     )
  //   );
  // } else {
  //   // Jika sudah ada, tambahkan qty atau update lainnya
  //  int lastQty = await mealRepo.getLastQty(idOrder, idMeal);
  //  int newQty = lastQty+=1;
  //  int newPrice = price*newQty;
  //  //List<Cart> toD = data;
 
  //   await mealRepo.updateCart(newQty, newPrice, idMeal, idOrder);
  // }
  //   getFromCart(idOrder);
  //   setState(() {
      
  //   });
  //   debugPrint(idMeal);
    
  // }

  //add to cart api
  Future<void> addToCartApi(String idMeal, int qty, int totalPrice) async {
    final add = await MealCartsApi.addToCart(idMealOrder,idMeal, qty, totalPrice);
    if(add)
    {
      cartList = await MealCartsApi.getCartById(idMealOrder);
      setState(() {
        countOrdered = cartList.length;
      });
    }
  }

  //menghapus atau mengurangi qty secara API
  Future<List<Cart>> deleteFromCartApi(String idMealCart,String idMeal) async {
    final delete = await MealCartsApi.destroy(idMealCart, idMeal);
    if(delete)
    {
      cartList = await MealCartsApi.getCartById(idMealCart);
      setState(() {
        countOrdered = cartList.length;
      });
    }
    return cartList;
  }

  //menghapus atau mengurangi qty data dari cart
  Future<void> removeFromCart(idOrder, idMeal, price) async {
    int lastQty = await mealRepo.getLastQty(idOrder, idMeal);
    if(lastQty == 1){
      await mealRepo.deleteCart(idOrder, idMeal);
    }else{
      int newQty = lastQty - 1;
      int newPrice = price * newQty;
      await mealRepo.updateCart(newQty, newPrice, idMeal, idOrder);
    }

    
      //getFromCart(idOrder);

    setState(() {
      //cartList = _temp;
      countOrdered = cartList.length;
    });
  }

  //mengambil data dari cart
  Future<void> getFromCartApi(idMealCart) async {
    cartList = await MealCartsApi.getCartById(idMealCart);
    setState(() {
      countOrdered = cartList.length;
    });
  }

  //menampilkan yang sudah dimasukkan ke dalam keranjang
  Future<void> getFromCart(idCart) async {

    cartList = await mealRepo.getCartById(idCart);

    setState(() {
      countOrdered = cartList.length;
    });
  }


  Future<void> getMeals() async {
    mealsList = await MealsApi.getMeals();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Pesanan Baru'),
        // actions: [
        //   IconButton(icon: const Icon(Icons.archive_outlined), onPressed: (){}),
        //   IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
        //   IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
        // ]
      ),
      body: ListView(
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
          const Row(
            children: [
              Icon(Icons.food_bank_outlined),
              Text(
                "Daftar Makanan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  ),
                ),
            ],
          ),
          const SizedBox(height: 15.0,),
          _isLoading ? const Center(
            child: CircularProgressIndicator(),   
              ) :
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              itemCount: mealsList.length,      
              itemBuilder: (context, index) => HorizontalCard2(
                idMeal: mealsList[index].idMeal,
                strMeal: mealsList[index].strMeal,
                strMealThumb: "${InitApi.urlApp}/storage/images/meals/${mealsList[index].strMealThumb}",
                price: mealsList[index].price,
                toDo: (){
                  // addToCart(
                  //   idOrder,
                  //   mealsList[index].idMeal,
                  //   mealsList[index].strMeal,
                  //   "http://10.0.2.2:8000/storage/images/meals/${mealsList[index].strMealThumb}",
                  //   1,
                  //   mealsList[index].price
                  // );
                  addToCartApi(
                    mealsList[index].idMeal,
                    1,
                    mealsList[index].price
                  );
                },
                ),
            ),
          const SizedBox(height: 100)
        ]
      ),
     floatingActionButton: Stack(
      alignment: Alignment.topRight,
      children: [
        FloatingActionButton(
          onPressed: () {
            //getFromCartApi(idMealOrder);
            showModalBottomSheet(
              context: context,
              builder: (context){
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Flex(
                          
                          direction: Axis.vertical,
                          children: [
                            const Text("Makanan Terpilih"),
                            Text("Order ID : $idMealOrder"),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartList.length,
                              itemBuilder: (context, index)=> Card(
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: NetworkImage("${InitApi.urlApp}/storage/images/meals/${cartList[index].strMealThumb}",scale: 1.0),
                                        fit: BoxFit.cover,
                                      )
                                    )
                                  ),
                                  title: Text("${cartList[index].strMeal} (${cartList[index].qty})"),
                                  subtitle: Text("Total : ${cartList[index].price}"),
                                  trailing: IconButton(
                                    onPressed: () async{
                                      //removeFromCart(cartList[index].idCart, cartList[index].idMeal, cartList[index].price);
                                      List<Cart> temp = await deleteFromCartApi(cartList[index].idMealCart, cartList[index].idMeal);
                                      //List<Cart> temp = await MealCartsApi.getCartById(cartList[index].idMealCart);
                                      setState((){
                                        cartList = temp;
                                      });
                                    },
                                    icon: const Icon(Icons.minimize),
                                  ),
                                ),
                              )
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DrinkPage(idMealsOrder: idMealOrder)
                                      )
                                    );
                                  },
                                  child: const Text("Pilih Minuman"),
                                ),
                                
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoadingPage(idMealCart: idMealOrder,idDrinkCart: null)
                                      )
                                    );
                                  },
                                  child: const Text("Bayar"),
                                ),

                              ],
                            )
                          ],
                        ),
                      )
                    );
                  },
                );
              }
            );
          },
          child: const Icon(Icons.shopping_cart_checkout),
        ),
        Positioned(
          top: 5.0,
          right: 5.0,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
            ),
            child: Text(
              "${cartList.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
     )
    );
  }
}

// SizedBox(
//         height: 90.0,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(10.0),      
//             ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text("data"),
//                 Text("data")
//               ],
//             ),
//           ),
//         )
// GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                     ),
//                     itemCount: mealsList.length,
//                     itemBuilder: (context, index) => HorizontalCardfood(
//                       strMeal: mealsList[index].strMeal,
//                       idMeal: mealsList[index].idMeal,
//                       strMealThumb: mealsList[index].strMealThumb,
//                       mealPrice: 24.0,
//                     ),
//                   ),