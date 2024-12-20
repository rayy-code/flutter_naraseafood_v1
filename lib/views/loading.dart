import 'package:flutter/material.dart';
import 'package:naraseafood/repository/api/orders.api.dart';
import 'package:naraseafood/views/payment_page.dart';
import 'package:uuid/uuid.dart';

class LoadingPage extends StatefulWidget{

  final String? idMealCart;
  final String? idDrinkCart;

  const LoadingPage({
    super.key, 
    this.idMealCart,
    this.idDrinkCart,
  });

@override
  State<LoadingPage> createState()=> _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
{
  late String uuidOrder ;

  //set uuid order
  void setUuidOrder() async {
    var data = const Uuid().v4();
    setState(() {
      uuidOrder = data;
    });
  }

  Future<void> addToOrder() async{
    String strIdMealCart = widget.idMealCart.toString();
    String strIdDrinkCart = widget.idDrinkCart.toString();
    final add = await OrdersApi.addToOrder(uuidOrder, strIdMealCart, strIdDrinkCart);
  if(add)
  {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentPage(idOrder: uuidOrder)
      )
    );
  }
  }

  //inisiasi
  @override
  void initState(){
    super.initState();
    setUuidOrder();
    addToOrder();
  }


  @override
  Widget build(BuildContext context)
  {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading'),
          ],
        ),
      ),
    );
  }
}