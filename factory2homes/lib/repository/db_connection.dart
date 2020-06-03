import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'appadmin_ecom_db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE carts("
        "id INTEGER PRIMARY KEY, "
        "productId INTEGER, "
        "productName TEXT, "
        "productListPrice INTEGER, "
        "productSalePrice INTEGER, "
        "productDiscount INTEGER, "
        "productTax INTEGER, "
        "productPhoto TEXT, "
        "productDescription TEXT, "
        "productWarranty TEXT, "
        "productQuantity INTEGER)");
  }
}
