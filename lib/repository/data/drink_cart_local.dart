import 'package:naraseafood/model/drink_cart.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class DrinkCartLocal {



  String tblDrinkCart = 'tbl_drink_cart';

  

  //menambahkan ke keranjang
  Future<void> addDrinkCart(DrinkCart drinkCart) async {
    final db = await AppDatabase.instance.database;
    await db.insert(tblDrinkCart, drinkCart.toMap());
  }

  //menampilkan semua data minuman yang dikeranjang
  Future<List<DrinkCart>> getDrinkCart() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblDrinkCart);
    return result.map((e)=> DrinkCart.fromMap(e)).toList();
  }

  //menampilkan data minuman di keranjang berdasarkan idDrinkCart
  Future<List<DrinkCart>> getDrinkCartById(int idDrinkCart) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblDrinkCart, where: 'idDrinkCart = ?', whereArgs: [idDrinkCart]);
    return result.map((e)=> DrinkCart.fromMap(e)).toList();
  }

  //mengambil data single dengan idDrinkCart dan idDrink
  Future<List<DrinkCart>> getDrinkCartByIdDrink(int idDrinkCart, String idDrink) async 
  {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblDrinkCart, where: 'idDrinkCart = ? AND idDrink = ?', whereArgs: [idDrinkCart, idDrink]);
    return result.map((e)=> DrinkCart.fromMap(e)).toList();
  }

  //mengecek idDrink maksimal

  //mengupdate single row
  Future<void> updateDrinkCart(int idDrinkCart, String idDrink, int qty, int price) async
  {
    final db = await AppDatabase.instance.database;
    await db.update(tblDrinkCart, {
      'qty': qty,
      'price': price,
    },
    where: "idDrinkCart = ? AND idDrink = ?",
    whereArgs: [idDrinkCart, idDrink]
    );
  }

  //mengambil qty terakhir dari idDrinkCart dan idDrink tertentu
  Future<int> getQtyLast(int idDrinkCart, String idDrink) async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery("SELECT qty FROM $tblDrinkCart WHERE idDrinkCart = $idDrinkCart AND idDrink = $idDrink");
    return result.first['qty'] as int;
  }
   //mengambil id maksimal
  Future<int> getMaxId() async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery('SELECT MAX(idDrinkCart) as maxId FROM $tblDrinkCart');
    // Jika tabel kosong, MAX(id) akan null, kembalikan 0.
    if (result.isNotEmpty && result.first['maxId'] != null) {
      return result.first['maxId'] as int;
    }
    return 0; // Default jika tidak ada data.
  }

  //menghapus data dari keranjang berdasarkan idDrinkCart dan idDrink
  Future<void> deleteDrinkCart(int idDrinkCart, String idDrink) async {
    final db = await AppDatabase.instance.database;
    await db.delete(tblDrinkCart, where: "idDrinkCart = ? AND idDrink = ?", whereArgs: [idDrinkCart, idDrink]);
  }
}