import 'package:naraseafood/model/order_model.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class OrderLocal {

  String tblOrder = "tbl_order";

  //menambahkan ke tabel order
  Future<void> newOrder(OrderModel order) async
  {
    final db = await AppDatabase.instance.database;
    await db.insert(tblOrder, order.toMap());
  }

  //mengambil semua data order
  Future<List<OrderModel>> getAllOrder() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblOrder);
    return result.map((e) => OrderModel.fromMap(e)).toList();
  }

  //mengambil data order berdasarkan idOrder
  Future <List<OrderModel>> getOrderById(int idOrder) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblOrder, where: "idOrder = ?", whereArgs:[idOrder]);
    return result.map((e)=> OrderModel.fromMap(e)).toList();
  }

  //menghitung total harga
  Future<int> totalHarga(int idOrder) async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery("SELECT SUM(totalPrice) as total FROM $tblOrder WHERE idOrder = $idOrder");
    return result[0]['total'] as int;
  }

  //menghapus berdasarkan idOrder
  Future<void> deleteOrder(int idOrder) async {
    final db = await AppDatabase.instance.database;
    await db.delete(tblOrder, where: "idOrder = ?", whereArgs: [idOrder]);
  }

  //mengambil idOrder tertinggi
  Future<int> getIdOrderTertinggi() async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery("SELECT MAX(idOrder) as idO FROM $tblOrder");
    return result[0]['idO'] as int;
  }

}