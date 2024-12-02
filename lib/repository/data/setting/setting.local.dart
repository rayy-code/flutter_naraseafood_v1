import 'package:naraseafood/model/setting/settings.model.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class SettingLocal {

  final String tblSetting = "tbl_setting";

  Future<void> newSetting(SettingsModel setting)async {
    final db = await AppDatabase.instance.database;
    await db.insert(tblSetting, setting.toMap());
  }

  //mengupdate pengaturan
  Future<void> updateSetting(int id, dynamic value)async {
    final db = await AppDatabase.instance.database;
    await db.update(tblSetting, {
      'value' : value
    }, where: "id = ?", whereArgs: [id]);
  }
}