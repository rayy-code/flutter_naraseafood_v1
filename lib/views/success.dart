import 'package:flutter/material.dart';
import 'package:naraseafood/views/dashboard.dart';

class Success extends StatelessWidget{

  final int excessMoney;

  const Success({super.key, required this.excessMoney});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            const Text('Success'),
            const SizedBox(height: 10),
            Text('Kembalian : $excessMoney'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
                );

              },
              child: const Text("Kembali Ke Dashboard"),
            )
          ],
        ),
      ),
    );
  }
}