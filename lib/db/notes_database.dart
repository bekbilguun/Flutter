import 'package:profile/model/inner_model.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/model/price_model.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _dbName = "lambda.db";

  static const cusmtomer =
      "CREATE TABLE CUSTOMERS (id INTEGER PRIMARY KEY, name TEXT, phone TEXT);";
  static const products =
      "CREATE TABLE PRODUCTS (id INTEGER PRIMARY key, name TEXT, barcode TEXT);";
  static const price =
      "CREATE TABLE PRICES (id INTEGER PRIMARY key, customerId TEXT, productId TEXT, price TEXT);";
  static const sales =
      "CREATE TABLE SALES (id INTEGER PRIMARY key, customerId INTEGER, customerName TEXT, total INTEGER, createdAt INTEGER);";
  static const saleProducrts =
      "CREATE TABLE SALE_PRODUCTS (id INTEGER PRIMARY key, saleId INTEGER, customerId INTEGER, productId INTEGER,productName TEXT, price INTEGER, count INTEGER, total INTEGER);";

  static Future<Database> _getDB() async {
    String path = join(await getDatabasesPath(), _dbName);

    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(cusmtomer);
      await db.execute(products);
      await db.execute(price);
      await db.execute(sales);
      await db.execute(saleProducrts);
    });
  }

  static Future<int> addCustomer(Customers customers) async {
    final db = await _getDB();
    print("_______________________IAM__CUSTOMER__ADD________________________");
    print(customers.toJson());
    return await db.insert("CUSTOMERS", customers.toJson());
  }

  static Future<int> updateCustomer(Customers customers) async {
    final db = await _getDB();
    return await db.update("CUSTOMERS", customers.toJson(),
        where: 'id = ?',
        whereArgs: [customers.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCustomer(Customers customers) async {
    final db = await _getDB();
    return await db
        .delete("CUSTOMERS", where: 'id = ?', whereArgs: [customers.id]);
  }

  static Future<List<Customers>?> getAllCustomers() async {
    final db = await _getDB();
    print("_____________________IAM_CUSTOMERS_LIST_________________________");
    final List<Map<String, dynamic>> maps = await db.query("CUSTOMERS");
    print(maps);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Customers.fromJson(maps[index]));
  }

  // --------------------------PRODUCTS--------------------------------

  static Future<int> addProduct(Products products) async {
    final db = await _getDB();
    print("____________________IAM__PRODUCT__ADD____________________________");
    return await db.insert("PRODUCTS", products.toJson());
  }

  static Future<int> updateProduct(Products products) async {
    final db = await _getDB();
    return await db.update("PRODUCTS", products.toJson(),
        where: 'id = ?',
        whereArgs: [products.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteProduct(Products products) async {
    final db = await _getDB();
    return await db
        .delete("PRODUCTS", where: 'id = ?', whereArgs: [products.id]);
  }

  static Future<List<Products>?> getAllProducts() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("PRODUCTS");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Products.fromJson(maps[index]));
  }

  static Future<List<Products>?> getPikerProducts(customer) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("PRODUCTS");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Products.fromJson(maps[index]));
  }

  static Future<List<Products>?> getSearchProducts(String keyword) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db
        .query('PRODUCTS', where: 'name LIKE ?', whereArgs: ['%$keyword%']);
    return List.generate(
        maps.length, (index) => Products.fromJson(maps[index]));
  }

  // ---------------------------PRICES-------------------------------
  static Future<int> checkPrice(Prices price) async {
    final db = await _getDB();
    final count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) as count from PRICES WHERE customerId = ? and productId = ?",
        [price.customerId, price.productId]));
    print("==========checkPrice==COUNT========================'$count'");
    return count!;
  }

  static Future<int> addPrice(Prices price) async {
    final db = await _getDB();
    final count = await checkPrice(price);
    if (count == 0) {
      return db.insert("PRICES", price.toJson());
    }
    return 0;
  }

  static Future<int> updatePrice(Prices prices) async {
    print("_______UPDATE_________updatePrice");
    final db = await _getDB();
    return await db.update("PRICES", prices.toJson(),
        where: 'id = ?',
        whereArgs: [prices.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deletePrice(id) async {
    final db = await _getDB();
    return await db.delete("PRICES", where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Inner>?> innerPriceCustomer(customer) async {
    final db = await _getDB();
    print("_______selectPrice______IAM_PRICES_LIST______selectPrice________");
    List list = await db.rawQuery(
        'SELECT p.id , p.price , p.customerId, p.productId, c.name, c.phone, c.id as CUSTOMER_ID FROM PRICES p INNER JOIN CUSTOMERS c ON p.customerId = c.id WHERE c.id=?',
        [customer.id]);
    print(list);
    // final List<Map<String, dynamic>> dbList = await db.rawQuery("SELECT p.price, p.customerId, p.productId, c.name FROM PRICES p INNER JOIN CUSTOMERS c ON p.id = c.id");
    // print(await db.query("CUSTOMERS"));
    if (list.isEmpty) {
      return null;
    }
    return List.generate(list.length, (index) => Inner.fromJson(list[index]));
  }

  static Future<List<Prices>?> getAllPrice() async {
    final db = await _getDB();
    print(
        "_____________________________IAM_PRICES_LIST___________________________________");
    final List<Map<String, dynamic>> maps = await db.query("PRICES");
    print(await db.query("PRICES"));
    print(await db.query("CUSTOMERS"));
    print(await db.query("PRODUCTS"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Prices.fromJson(maps[index]));
  }

// ----------------------------------SALE--------------------------------------------
  static Future<int> addSale(Sale sale) async {
    final db = await _getDB();
    print("____________________IAM__SALE__ADD____________________________");
    final addsale = await db.insert("SALES", sale.toJson());
    print(sale.toJson());
    return addsale;
  }

  static Future<List<Sale>?> getAllSales() async {
    final db = await _getDB();
    print("_____________________IAM_Sale_LIST_________________________");
    final List<Map<String, dynamic>> maps = await db.query("SALES");
    print(await db.query("SALES"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Sale.fromJson(maps[index]));
  }

  static Future<List<Sale>?> getSales(DateTime startDate, DateTime ?endDate) async {
    int startTimestamp = startDate.millisecondsSinceEpoch;
    int endTimestamp = endDate!.millisecondsSinceEpoch;
    print("startDate $startDate: $startTimestamp");
    print("endDatae $endDate: $endTimestamp");
    final db = await _getDB();
    print("_____________________IAM_Sale_DATE_FILTERS_______________");
    List list = await db.rawQuery("SELECT * FROM SALES WHERE createdAt > ? and createdAt < ?", [startTimestamp, endTimestamp]);
    final count = await db.rawQuery("SELECT count(*)as count , sum(total) as total from SALES WHERE createdAt >= ? and createdAt < ?", [startTimestamp, endTimestamp]);
    print(list);
    print("COUNT______: $count");
    // print("total: $total");
    if (list.isEmpty) {
      return null;
    }
    return List.generate(list.length, (index) => Sale.fromJson(list[index]));
  }
  static getSaleStats(DateTime startDate, DateTime ?endDate) async {
    int startTimestamp = startDate.millisecondsSinceEpoch;
    int endTimestamp = endDate!.millisecondsSinceEpoch;
    print("startDate $startDate: $startTimestamp");
    print("endDatae $endDate: $endTimestamp");
    final db = await _getDB();
    print("_____________________IAM_getSaleStats_______________");
    final count = await db.rawQuery("SELECT count(*) as count , sum(total) as total from SALES WHERE createdAt >= ? and createdAt < ?", [startTimestamp, endTimestamp]);
    print("COUNT______: $count");
    // print("total: $total");
    if (count.isEmpty) {
      return null;
    }
    return count[0];
  }

// -------------------------------SALE-PRODUCT---------------------------------------
  static Future<int> addSaleProduct(SaleProduct saleProduct) async {
    final db = await _getDB();
    print(
        "____________________IAM__ADD__SALE__PRODUCT________________________");
print(saleProduct.toJson());
    final addsale = await db.insert("SALE_PRODUCTS", saleProduct.toJson());
    print(saleProduct.toJson());
    return addsale;
  }

  static Future<List<SaleProduct>?> getAllSaleProducts(Sale) async {
    final db = await _getDB();
    print("_____________________IAM_Sale_LIST___PRODUCT______________________");
    final List<Map<String, dynamic>> maps = await db.query("SALE_PRODUCTS", where: 'saleId = ?', whereArgs: [Sale.id]);
    print(await db.query("SALE_PRODUCTS"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => SaleProduct.fromJson(maps[index]));
  }
}
