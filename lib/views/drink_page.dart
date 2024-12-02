import 'package:flutter/material.dart';
import 'package:naraseafood/model/cart.dart';
import 'package:naraseafood/model/drink_cart.dart';
import 'package:naraseafood/model/drinks.dart';
import 'package:naraseafood/model/order_model.dart';
import 'package:naraseafood/repository/api/drinks.api.dart';
import 'package:naraseafood/repository/data/cart_local.dart';
import 'package:naraseafood/repository/data/drink_cart_local.dart';
import 'package:naraseafood/repository/data/order_local.dart';
import 'package:naraseafood/views/payment_page.dart';
import 'package:naraseafood/views/widgets/horizontal_card2.dart';

class DrinkPage extends StatefulWidget{
  final int? idMealsOrder;

  const DrinkPage({super.key, this.idMealsOrder});

  @override
  State<DrinkPage> createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> 
{
  bool isLoading = true;
  bool toNexPage = false;
  late List<Drinks> drinkList = [];
  int idDrinkOrder = 0;
  final drinkRepo = DrinkCartLocal();
  final orderRepo = OrderLocal();
  final mealRepo = CartLocal();
  List<DrinkCart> cartList = [];
  List<Cart> mealOrderedList = [];
  int countOrdered = 0;
  int idOrder =0;
  int totalDrinkPrice = 0;
  int totalMealPrice = 0;
  int totalCost = 0;



  Future<void> getDrinks () async {
    drinkList = await DrinksApi.getDrinks();
    
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getFromCart(idDrinkCart) async 
  {
    cartList = await drinkRepo.getDrinkCartById(idDrinkCart);

    setState(() {
      countOrdered = cartList.length;
    });
  }

  void setId() async {
    int lastId = await drinkRepo.getMaxId();
    setState(() {
      idDrinkOrder = lastId + 1;
    });
    
  }

  //fungsi untuk menambahkan minuman ke keranjang
  void addDrinkToCart(DrinkCart drink) async{
    //mengecek apakah data sudah ada
    List<DrinkCart> _temp = await drinkRepo.getDrinkCartByIdDrink(drink.idDrinkCart, drink.idDrink);

    if(_temp.length == 1)
    {
      int lastQty = await drinkRepo.getQtyLast(drink.idDrinkCart, drink.idDrink);
      int newQty = lastQty + 1;
      int newPrice = newQty * drink.price;

      await drinkRepo.updateDrinkCart(drink.idDrinkCart, drink.idDrink, newQty, newPrice);
    }else{
      await drinkRepo.addDrinkCart(
        DrinkCart(
          idDrinkCart: drink.idDrinkCart,
          idDrink: drink.idDrink,
          strDrink: drink.strDrink,
          strDrinkThumb: drink.strDrinkThumb,
          qty: drink.qty,
          price: drink.price
        )
      );
    }
    getFromCart(drink.idDrinkCart);
  }

  //menghapus dari DrinkCart
  Future<void> deleteDrinkFromCart(idDrinkCart, idDrink, price) async{
    int lastQty = await drinkRepo.getQtyLast(idDrinkCart, idDrink);
    if(lastQty == 1)
    {
      await drinkRepo.deleteDrinkCart(idDrinkCart, idDrink);
    }else{
      int newQty = lastQty - 1;
      int newPrice = price * newQty;
      await drinkRepo.updateDrinkCart(idDrinkCart, idDrink, newQty, newPrice);
    }
    setState(() {
      countOrdered = cartList.length;
    });
  }

  //mengambil total harga dari Meal dan Drink
  Future<void> getTotalPrice() async{
    int totalMeal = 0;
    int mealId = 0;
    if(widget.idMealsOrder != null){
      mealId = widget.idMealsOrder as int;
      debugPrint("Id Meals : $mealId");
      mealOrderedList = await mealRepo.getCartById(mealId);
      if(mealOrderedList.isNotEmpty)
      {
        debugPrint("Jumlah baris pada idMeal $mealId : ${mealOrderedList.length}");
        int mealPrice = 0;
        for(int i = 0; i < mealOrderedList.length; i++)
        {
          mealPrice += mealOrderedList[i].price;
        }
        totalMeal = mealPrice;
      }
    }
    debugPrint("Total Meal cost : $totalMeal");
    int totalPrice = 0;
    for(int i = 0; i < cartList.length; i++)
    {
      totalPrice += cartList[i].price;
    }
    
    setState(() {
      totalCost = totalPrice + totalMeal;
    });
    debugPrint("total : $totalCost");
  }

  Future<void> setIdOrder() async
  {
    int maxIdOrder = await orderRepo.getIdOrderTertinggi();
    int newIdOrder = maxIdOrder + 1;
    setState(() {
      toNexPage = true;
      idOrder = newIdOrder;
    });
  }

  Future<void> addToOrder(OrderModel order) async 
  {
    await orderRepo.newOrder(order);
    setState(() {
      toNexPage = false;
    });
  }

  Future<void> nextStep() async
  {
    getTotalPrice();
    setIdOrder();
    //int total = totalDrinkPrice + totalMealPrice;
    debugPrint("ini sebelum dimasukkin ke tblOrder : $totalCost" );
    addToOrder(
      OrderModel(
        idOrder: idOrder,
        idMealCart: widget.idMealsOrder,
        idDrinkCart: idDrinkOrder,
        totalPrice: totalCost
      )
    );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PaymentPage(idOrder: idOrder))
    );
  }

  @override 
  void initState()
  {

    super.initState();
    getDrinks();
    setId();
    setIdOrder();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drinks'),
        centerTitle: true,
        clipBehavior: Clip.hardEdge,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 25.0),
          isLoading ? const Center(
            child: CircularProgressIndicator(),
          ) :
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: drinkList.length,
            itemBuilder: (context, index) => HorizontalCard2(
              idMeal: drinkList[index].idDrink,
              strMeal: drinkList[index].strDrink,
              strMealThumb: drinkList[index].strDrinkThumb,
              price: drinkList[index].price.toDouble(),
              toDo: (){
                addDrinkToCart(
                  DrinkCart(
                    idDrinkCart: idDrinkOrder,
                    idDrink: drinkList[index].idDrink,
                    strDrink: drinkList[index].strDrink,
                    strDrinkThumb: drinkList[index].strDrinkThumb,
                    qty: 1,
                    price: drinkList[index].price,
                  )
                );
                debugPrint(drinkList[index].idDrink);
              },
            )
          ),
          
        ],
      ),
      floatingActionButton: Stack(
      alignment: Alignment.topRight,
      children: [
        FloatingActionButton(
          onPressed: () {
            //getFromCart(idOrder);
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
                            const Text("Minuman Terpilih"),
                            Text("Order ID : $idDrinkOrder"),
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
                                        image: NetworkImage(cartList[index].strDrinkThumb),
                                        fit: BoxFit.cover,
                                      )
                                    )
                                  ),
                                  title: Text("${cartList[index].strDrink} (${cartList[index].qty})"),
                                  subtitle: Text("Total : ${cartList[index].price}"),
                                  trailing: IconButton(
                                    onPressed: () async{
                                      deleteDrinkFromCart(cartList[index].idDrinkCart, cartList[index].idDrink, cartList[index].price);

                                       List<DrinkCart> temp = await drinkRepo.getDrinkCartById(idDrinkOrder);
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
                                    nextStep();
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
          child: const Icon(Icons.shop_rounded),
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