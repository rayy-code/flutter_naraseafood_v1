import 'package:naraseafood/model/payment_model.dart';
import 'package:naraseafood/repository/data/app_database.dart';

class PaymentLocal {

  String tblPayment = "tbl_payment";

  //menambahkan data payment
  Future<void> newPayment(PaymentModel payment) async
  {
    final db = await AppDatabase.instance.database;
    await db.insert(tblPayment, payment.toMap());
  } 

  //menampilkan semua data payment
  Future<List<PaymentModel>> getAllPayment() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblPayment);
    return result.map((e) => PaymentModel.fromMap(e)).toList();
  }

  //mengambil data payment berdasarkan idPayment
  Future<List<PaymentModel>> getPaymentById(int idPayment) async
  {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tblPayment, where: "idPayment = ?", whereArgs:[idPayment]);
    return result.map((e) => PaymentModel.fromMap(e)).toList();
  }

  //mengambil idMaksimal
  Future<int> getMaxIdPayment() async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery("SELECT MAX(idPayment) FROM $tblPayment");
    return result[0]['MAX(idPayment)'] as int;
  }

}