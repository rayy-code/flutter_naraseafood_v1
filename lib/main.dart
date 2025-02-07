import 'package:flutter/material.dart';
import 'package:naraseafood/views/dashboard.dart';
import 'package:naraseafood/views/drink_page.dart';
import 'package:naraseafood/views/home.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Dashboard(),
        '/home': (context) => const HomePage(),
        '/drinks' : (context)=> const DrinkPage(),
      },
      //home: const Dashboard(),
    );
  }
}

