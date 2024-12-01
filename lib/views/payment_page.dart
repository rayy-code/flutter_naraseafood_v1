import 'package:flutter/material.dart';
import 'package:naraseafood/model/cart.dart';
import 'package:naraseafood/model/drink_cart.dart';
import 'package:naraseafood/model/order_model.dart';
import 'package:naraseafood/model/payment_model.dart';
import 'package:naraseafood/repository/data/cart_local.dart';
import 'package:naraseafood/repository/data/drink_cart_local.dart';
import 'package:naraseafood/repository/data/order_local.dart';
import 'package:naraseafood/repository/data/payment_local.dart';
import 'package:naraseafood/views/success.dart';

class PaymentPage extends StatefulWidget{

  final int idOrder;

  const PaymentPage({super.key, required this.idOrder});

  @override
  State<PaymentPage> createState()=> _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>{

  late List<Cart> mealList = [];
  late List<DrinkCart> drinkList = [];
  final orderRepo = OrderLocal();
  final mealRepo = CartLocal();
  final drinkRepo = DrinkCartLocal();
  final paymentRepo = PaymentLocal();
  final TextEditingController uangBayar = TextEditingController();
  int idPayment = 0;
  int totalCost = 0;
  int exceesMoney = 0;
  bool uangCukup = true;

  Future<void> getOrder() async
  {
    int totalMealPrice = 0;
    List<OrderModel> order = await orderRepo.getOrderById(widget.idOrder);
    if(order.first.idMealCart != null){
      int idMeal = order.first.idMealCart as int;
      if(idMeal != 0)
      {
        mealList = await mealRepo.getCartById(idMeal);
        for (int i = 0; i < mealList.length; i++) {
          totalMealPrice += mealList[i].price;
        }
      }
    }
    int idDrink = order.first.idDrinkCart as int;
    drinkList = await drinkRepo.getDrinkCartById(idDrink);
    for(int i = 0; i < drinkList.length; i++)
    {
      totalCost += drinkList[i].price;
    }
    setState(() {
      totalCost += totalMealPrice;
    });
    
  }

  Future<void> setIdPayment()async 
  {
    int maxId = await paymentRepo.getMaxIdPayment();
    setState(() {
      idPayment = maxId + 1;
    });
  }

  Future<void> goPayment() async {
    
    int pay = int.parse(uangBayar.text);
    if(pay < totalCost)
    {
      setState(() {
        uangCukup = false;
      });
    }else{
      exceesMoney = pay - totalCost;
      if (exceesMoney >= 0) {
        setState(() {
          paymentRepo.newPayment(
            PaymentModel(
              idOrder: widget.idOrder,
              idPayment: idPayment,
              totalPrice: totalCost,
              pay: pay,
              excessMoney: exceesMoney,
            )
          );
        });
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Success(excessMoney: exceesMoney)
        )
      );
    }
  }

  @override
  void initState()
  {
    super.initState();
    getOrder();
    setIdPayment();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: ListView(
          children: <Widget>[
            const Center(
              child: Text("Pembayaran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                      image: NetworkImage(mealList[index].strMealThumb),
                      fit: BoxFit.cover,
                        )
                      )
                    ),
                  title: Text("${mealList[index].strMeal} (${mealList[index].qty})"),
                  subtitle: Text("Total : ${mealList[index].price}"),
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
                      image: NetworkImage(drinkList[index].strDrinkThumb),
                      fit: BoxFit.cover,
                        )
                      )
                    ),
                  title: Text("${drinkList[index].strDrink} (${drinkList[index].qty})"),
                  subtitle: Text("Total : ${drinkList[index].price}"),
                ),
              )
            ),
            const SizedBox(height: 20),
            Text("Total Tagihan : Rp. $totalCost"),
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
                goPayment();
              },
              child: const Text("Bayar"),
            )
          ],
        ),
      )
    );
  }
}
