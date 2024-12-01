import 'package:naraseafood/model/cart.dart';
import 'package:naraseafood/repository/data/app_database.dart';


class CartLocal {
  
  String tblCart = 'tbl_cart';
  // menambahkan ke kerjanjang/cart
  Future<void> addCart(Cart cart) async {
    final db = await AppDatabase.instance.database;
    await db.insert(tblCart, cart.toMap());
  }
  

  //menampilkan semua data order
  Future<List<Cart>> getCart() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblCart);
    return result.map((e)=> Cart.fromMap(e)).toList();
  }

  //menampilkan berdasarkan id
  Future<List<Cart>> getCartById(int idCart) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblCart, where: 'idCart = ?', whereArgs: [idCart]);
    return result.map((e)=> Cart.fromMap((e))).toList();
  }
  //menampilkan berdasarkan idMeal dan idOrder
  Future<List> getCartByIdMealAndIdCart(String idMeal, int idCart) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblCart, where: 'idMeal = ? AND idCart = ?', whereArgs: [idMeal, idCart]);
    return result.map((e)=> Cart.fromMap((e))).toList();
  }

  //mengecek apakah id sudah ada
  Future<bool> checkId(int idCart) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblCart, where: 'idCart = ?', whereArgs: [idCart]);
    return result.isNotEmpty;
  }

  //mengambil id maksimal
  Future<int> getMaxId() async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery('SELECT MAX(idCart) as maxId FROM $tblCart');
    // Jika tabel kosong, MAX(id) akan null, kembalikan 0.
    if (result.isNotEmpty && result.first['maxId'] != null) {
      return result.first['maxId'] as int;
    }
    return 0; // Default jika tidak ada data.
  }

  //update qty dan price jika idCart sama
  Future<void> updateCart(int newQty, int newPrice, String idMeal, int idCart) async {
    final db = await AppDatabase.instance.database;
    await db.update(tblCart, {
      'qty': newQty,
      'price': newPrice,
    }, where: 'idMeal = ? AND idCart = ?', whereArgs:[idMeal, idCart]);
  }

  //menghapus data 
  Future<void> deleteCart(int idCart, String idMeal) async {
    final db = await AppDatabase.instance.database;
    await db.delete(tblCart, where: 'idCart = ? AND idMeal = ?', whereArgs: [idCart, idMeal]);
  }

  //mengecek apakah idCart dan idMeal sudah ada
  Future<bool> checkIdCartAndMeal(int idCart, String idMeal) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblCart, where: 'idCart = ? AND idMeal = ?', whereArgs: [idCart, idMeal]);
    return result.isNotEmpty;
  }

  //mengambil quantity terakhir
  Future<int> getLastQty(int idCart, String idMeal) async
  {
    final db = await AppDatabase.instance.database;
    final result = await db.query(
      tblCart,
      columns: ['qty'],
      where: "idCart = ? AND idMeal = ?",
      whereArgs: [idCart,idMeal]
    );
    
    return result.first['qty'] as int;
  }

}