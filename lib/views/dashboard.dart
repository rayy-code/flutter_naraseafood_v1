import 'package:flutter/material.dart';
import 'package:naraseafood/helper/format_string.dart';
import 'package:naraseafood/repository/api/payment.api.dart';
import 'package:naraseafood/views/drink_page.dart';
import 'package:naraseafood/views/history.dart';
import 'package:naraseafood/views/home.dart';
import 'package:naraseafood/views/setting_page.dart';
import 'package:naraseafood/views/widgets/card_icon.dart';
import 'package:naraseafood/views/widgets/header_dashboard.dart';
import 'package:naraseafood/views/widgets/sales.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{

  int pageIndex = 0;

  String totalSales = "";
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

  Future<void> getSales() async
  {
    DateTime today = DateTime.now();
    String formated = DateFormat('yyyy-MM-dd').format(today);
    final sales = await PaymentApi.getTotalSalesByDate(formated);
    String rupiah = FormatString.toRupiah(sales);
    //debugPrint("$sales");
    setState(() {
      totalSales = rupiah;
    });
  }

  @override
  void initState()
  {
    super.initState();
    getSales();
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlue,
      //   foregroundColor: Colors.white,
      //   title: const Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       Image(image: AssetImage('images/profile_2.png')),
      //       SizedBox(width: 5.0,),
      //       //Icon(Icons.food_bank),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: <Widget>[
      //           Text('Hi, Rayyanda', style: TextStyle(
      //             fontSize: 12,
      //           ),),
      //           Text('@rayyanda5113', style: TextStyle(
      //             fontSize: 12,
      //             fontWeight: FontWeight.bold
      //           ),),
      //         ],
      //       )
      //     ],
      //   ),
      //   actions: [
      //     IconButton(icon: const Icon(Icons.archive_outlined), onPressed: (){}),
      //     IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
      //     IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
      //   ]
      // ),
      body: <Widget>[
        Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                headerDashboard("Dhihya Rayyanda", "User"),
                sales(totalSales,onClick: (){
                  getSales();
                }),
              ]
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {

                  //   },
                  //   child: const Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Icon(Icons.shop),
                  //       Text('Pembelian', style: TextStyle(fontSize: 12),),
                  //     ]
                  //   )
                  // ),
                  CardIcon(
                    cardIcon: const Icon(Icons.shopping_bag, size: 50.0, color: Colors.blueAccent,),
                    title: 'New Order',
                    toDo: (){
                      goToPage();
                    },
                    ),
                  CardIcon(
                    cardIcon: const Icon(Icons.local_bar, size: 50.0, color: Colors.blueAccent,),
                    title: 'Drinks',
                    toDo: (){
                      toDrinkPage();
                    },
                  ),
                  CardIcon(
                    cardIcon: const Icon(Icons.settings, size: 50.0, color: Colors.blueAccent,),
                    title: 'Settings',
                    toDo: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> const SettingPage())
                      );
                    },
                    ),
                  CardIcon(
                    cardIcon: const Icon(Icons.info_outline, size: 50.0, color: Colors.blueAccent,),
                    title: 'Tentang Aplikasi',
                    toDo: (){
                    
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      const HistoryPage(),
      ][pageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        shadowColor: Colors.white,
        onDestinationSelected: (int index){
          setState(() {
            pageIndex = index;
          });
        },
        selectedIndex: pageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
    );
  }
}