import 'package:naraseafood/model/setting/settings.model.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class SettingLocal {

  final String tblSetting = "tbl_setting";

  Future<void> newSetting(SettingsModel setting)async {
    final db = await AppDatabase.instance.database;
    await db.insert(tblSetting, setting.toMap());
  }

  //mengambil data berdasarkan nama
  Future<String> getSetting(String nama) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblSetting, where: "settingName = ?", whereArgs: [nama]);
    return result[0]['value'] as String;
  }

  //mengupdate pengaturan
  Future<void> updateSetting(String settingName, dynamic value)async {
    final db = await AppDatabase.instance.database;
    await db.update(tblSetting, {
      'value' : value
    }, where: "settingName = ?", whereArgs: [settingName]);
  }
}