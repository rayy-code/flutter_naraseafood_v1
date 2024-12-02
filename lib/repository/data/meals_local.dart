import 'package:naraseafood/model/meals.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class MealsLocal {

  final String tblMeals = "tbl_meals";

  //menambahkan meals baru
  Future<void> addMeals(Meals meals) async {
    final db = await AppDatabase.instance.database;
    await db.insert(tblMeals, meals.toMap());
  }

  //menghapus meals
  Future<void> deleteMeals(int idMeals) async {
    final db = await AppDatabase.instance.database;
    await db.delete(tblMeals, where: 'id = ?', whereArgs: [idMeals]);
  }

  //mengupdate meals
  Future<void> updateMeals(Meals meals) async {
    final db = await AppDatabase.instance.database;
    await db.update(tblMeals, {
      'strMeal': meals.strMeal,
      'strMealThumb': meals.strMealThumb,
    }, where: "id = ?", whereArgs: [meals]);
  }

}