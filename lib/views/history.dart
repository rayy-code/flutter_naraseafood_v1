import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naraseafood/helper/format_string.dart';
import 'package:naraseafood/repository/api/payment.api.dart';

class HistoryPage extends StatefulWidget{
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
{

  String totalSales = "";

  Future<void> getAllSales() async {
    DateTime today = DateTime.now();
    String formated = DateFormat('yyyy-MM').format(today);
    final sales = await PaymentApi.getTotalSalesByDate(formated);
    String rupiah = FormatString.toRupiah(sales);
    //debugPrint("$sales");
    setState(() {
      totalSales = rupiah;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Text(
              "Total Sales This Month : $totalSales"
            )
          ]
        ),
      )
    );
  }
}