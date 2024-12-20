import 'package:flutter/material.dart';
import 'package:naraseafood/helper/format_string.dart';
import 'package:naraseafood/model/cart.dart';
import 'package:naraseafood/model/drink_cart.dart';
import 'package:naraseafood/repository/api/init_api.dart';
//import 'package:naraseafood/model/drink_cart.dart';
//import 'package:naraseafood/model/order_model.dart';
//import 'package:naraseafood/model/payment_model.dart';
import 'package:naraseafood/repository/api/orders.api.dart';
import 'package:naraseafood/repository/api/payment.api.dart';
import 'package:naraseafood/repository/data/cart_local.dart';
import 'package:naraseafood/repository/data/drink_cart_local.dart';
import 'package:naraseafood/repository/data/order_local.dart';
import 'package:naraseafood/repository/data/payment_local.dart';
import 'package:naraseafood/views/success.dart';

class PaymentPage extends StatefulWidget{

  final String idOrder;

  const PaymentPage({super.key, required this.idOrder});

  @override
  State<PaymentPage> createState()=> _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>{

  late List<Cart> mealList = [];
  late List drinkList = [];
  List lsMealQty = [];
  List lsDrinkQty = [];
  final orderRepo = OrderLocal();
  final mealRepo = CartLocal();
  final drinkRepo = DrinkCartLocal();
  final paymentRepo = PaymentLocal();
  final TextEditingController uangBayar = TextEditingController();
  int idPayment = 0;
  int totalCost = 0;
  int exceesMoney = 0;
  bool uangCukup = true;

  // Future<void> getOrder() async
  // {
  //   int totalMealPrice = 0;
  //   List<OrderModel> order = await orderRepo.getOrderById(widget.idOrder);
  //   if(order.first.idMealCart != null){
  //     int idMeal = order.first.idMealCart as int;
  //     if(idMeal != 0)
  //     {
  //       mealList = await mealRepo.getCartById(idMeal);
  //       for (int i = 0; i < mealList.length; i++) {
  //         totalMealPrice += mealList[i].price;
  //       }
  //     }
  //   }
  //   int idDrink = order.first.idDrinkCart as int;
  //   drinkList = await drinkRepo.getDrinkCartById(idDrink);
  //   for(int i = 0; i < drinkList.length; i++)
  //   {
  //     totalCost += drinkList[i].price;
  //   }
  //   setState(() {
  //     totalCost += totalMealPrice;
  //   });
    
  // }

  Future<void> getOrderApi() async
  {
    Map<String, dynamic> data = await OrdersApi.getDataOrder(widget.idOrder);
    //debugPrint("total Price : ${data['data']['order']['total_price']}");
    String idMealCart = data['data']['order']['idMealCart'];
    String idDrinkCart = data['data']['order']['idDrinkCart'];
    //List mealCarts =[];
    List lsMealQty = [];
    List lsTp = [];
    List lsMealCart = [];
    List mealCarts = data['data']['order']['meal_carts'];
    for (var i in mealCarts) {
      lsMealCart.add(i['meal']);
      lsMealQty.add(i['qty']);
      lsTp.add(i['totalPrice']);
    }
    for (var i = 0; i < lsMealCart.length; i++) {
      lsMealCart[i]['qty'] = lsMealQty[i];
      lsMealCart[i]['price'] = lsTp[i];
      lsMealCart[i]['idMealCart'] = idMealCart;
    }
    debugPrint("Meal : $lsMealCart");
    List drinkCarts = data['data']['order']['drink_carts'];
    List lsDrinkQty = [];
    List lsDrinkTp = [];
    List lsDrinkCart = [];
    for (var i in drinkCarts) {
      lsDrinkCart.add(i['drink']);
      lsDrinkQty.add(i['qty']);
      lsDrinkTp.add(i['totalPrice']);
    }
    for (var i = 0; i < drinkCarts.length; i++) {
      lsDrinkCart[i]['qty']= lsDrinkQty[i];
      lsDrinkCart[i]['price'] = lsDrinkTp[i];
      lsDrinkCart[i]['idDrinkCart'] = idDrinkCart;
    }
    setState(() {
      mealList = Cart.mealsFromSnapshot(lsMealCart);
      drinkList = DrinkCart.cartFromSnapshot(lsDrinkCart);
      totalCost = data['data']['order']['total_price'];
    });
  }

  Future<void> setIdPayment()async 
  {
    int maxId = await paymentRepo.getMaxIdPayment();
    setState(() {
      idPayment = maxId + 1;
    });
  }

  Future<void> goPaymentApi() async
  {
    int pay = int.parse(uangBayar.text);

    int exceesMoney = await PaymentApi.addPayment(widget.idOrder, totalCost, pay);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Success(excessMoney: exceesMoney)
      )
    );

  }

  // Future<void> goPayment() async {
    
  //   int pay = int.parse(uangBayar.text);
  //   if(pay < totalCost)
  //   {
  //     setState(() {
  //       uangCukup = false;
  //     });
  //   }else{
  //     exceesMoney = pay - totalCost;
  //     if (exceesMoney >= 0) {
  //       setState(() {
  //         paymentRepo.newPayment(
  //           PaymentModel(
  //             idOrder: widget.idOrder,
  //             idPayment: idPayment,
  //             totalPrice: totalCost,
  //             pay: pay,
  //             excessMoney: exceesMoney,
  //           )
  //         );
  //       });
  //     }
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => Success(excessMoney: exceesMoney)
  //       )
  //     );
  //   }
  // }

  @override
  void initState()
  {
    super.initState();
    getOrderApi();
    //setIdPayment();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: ListView(
          children: <Widget>[
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Pembayaran",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      getOrderApi();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Text("Makanan dipesan : ${mealList.length}"),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mealList.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage("${InitApi.urlApp}/storage/images/meals/${mealList[index].strMealThumb}"),
                      fit: BoxFit.cover,
                        )
                      )
                    ),
                  title: Text("${mealList[index].strMeal} (${mealList[index].qty})"),
                  subtitle: Text(FormatString.toRupiah(mealList[index].price)),
                )
              )
            ),
            const SizedBox(height: 20),
            Text("Minuman dipesan : ${drinkList.length}"),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: drinkList.length,
              itemBuilder: (context, index)=> Card(
                child: ListTile(
                  leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage("${InitApi.urlApp}/storage/images/drinks/${drinkList[index].strDrinkThumb}"),
                      fit: BoxFit.cover,
                        )
                      )
                    ),
                  title: Text("${drinkList[index].strDrink} (${drinkList[index].qty})"),
                  subtitle: Text(FormatString.toRupiah(drinkList[index].price)),
                ),
              )
            ),
            const SizedBox(height: 20),
            Text("Total Tagihan :${FormatString.toRupiah(totalCost)}"),
            const SizedBox(height: 20),
            const Text("Uang Bayar : Rp. "),
            const SizedBox(height: 10.0),
            TextField(
              controller: uangBayar,
              decoration: const InputDecoration(
                hintText: "Rp. xxxxx"
              ),
            ),
            ElevatedButton(
              onPressed: (){
                goPaymentApi();
              },
              child: const Text("Bayar"),
            )
          ],
        ),
      )
    );
  }
}
