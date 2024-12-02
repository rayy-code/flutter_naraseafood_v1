import 'package:flutter/material.dart';
import 'package:naraseafood/repository/data/setting/setting.local.dart';

class SettingDatasourcePage extends StatefulWidget{
  const SettingDatasourcePage({
    super.key,
  });

  @override
  State<SettingDatasourcePage> createState() => _SettingDataSourcePageState();
}

class _SettingDataSourcePageState extends State<SettingDatasourcePage>
{
  final settingRepo = SettingLocal();
  late String apiFood;
  late String apiDrink;
  bool useLocal = false;
  TextEditingController urlApiFood = TextEditingController();
  TextEditingController urlApiDrink = TextEditingController();

  Future<void> getSettingSource() async {
    String source = await settingRepo.getSetting("loadData");
    debugPrint(source);

    if(source == "api"){
      apiFood = await settingRepo.getSetting("apiFood");
      apiDrink = await settingRepo.getSetting("apiDrink");
      setState(() {
        urlApiFood.text = apiFood ;
        urlApiDrink.text = apiDrink ;
        useLocal = false;
      });
    }else{
      setState(() {
        useLocal = true;
      });
    }
  }

  Future<void> updateSetting(bool value)async
  {
    if(value == false)
    {
      await settingRepo.updateSetting("loadData", "local");
      setState(() {
        useLocal = true;
      });
    }else{
      await settingRepo.updateSetting("loadData", "api");
      setState(() {
        useLocal = false;
      });
    }
  }

  

  @override
  void initState()
  {
    super.initState();
    getSettingSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Atur Sumber Data',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
        children: [
          ListTile(
            title: const Text('Gunakan Data Lokal'),
            subtitle: const Text("Data seperti menu makanan dan minuman akan diambil dari database lokal"),
            trailing: Switch(
              value: useLocal, 
              activeColor: Colors.lightBlueAccent,
              onChanged: (bool value) {
              setState(() {
                useLocal = value;
                if(value)
                {
                  settingRepo.updateSetting("loadData", "local");
                }else{
                  settingRepo.updateSetting("loadData", "api");
                }
              });
            }
          )
          ),
          const SizedBox(height: 14),
          useLocal ? 
          //jika menggunakan data lokal
          const SizedBox(height: 9.0)
          :
          //jika menggunakan api
          TextField(
            decoration: const InputDecoration(
              labelText: 'Masukkan URL API Makanan',
              border: OutlineInputBorder(),
            ),
            controller: urlApiFood,
            
          ),
          const SizedBox(height: 20),
          useLocal ?
          const SizedBox(height: 9.0) :
          TextField(
            decoration: const InputDecoration(
              labelText: 'Masukkan URL API Minuman',
              border: OutlineInputBorder(),
              focusColor: Colors.green
            ),
            controller: urlApiDrink,
            cursorColor: Colors.green,
          ) 
          
        ]
      ),
    )
  );
  }
}