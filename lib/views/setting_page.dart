import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Setting',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
        children: <Widget> [
          Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/set_datasource");
                debugPrint("Item Clicked");
              },
              child: ListTile(
              leading: const Icon(Icons.dataset),
              title: const Text("Atur Sumber Data"),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pushNamed(context, "/set_datasource");
                  debugPrint("item Clicked");
                }
              )
            ),
            )
          )
        ],
      ),
      )
    );
  }
}