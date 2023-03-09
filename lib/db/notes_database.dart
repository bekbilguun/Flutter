import 'package:profile/model/inner_model.dart';
import 'package:profile/model/customer_model.dart';
import 'package:profile/model/price_model.dart';
import 'package:profile/model/product_model.dart';
import 'package:profile/model/sale_model.dart';
import 'package:profile/model/sale_product_model.dart';
import 'package:profile/utils/app_logger.dart';
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
    void _updateTableAddColumnV1toV2(Batch batch) {
      batch.execute(
          "ALTER TABLE CUSTOMERS ADD COLUMN registerNo INTEGER DEFAULT uk00301833");
    }

    void _dropTableEmployeeV2(Batch batch) {
      batch.execute("ALTER TABLE CUSTOMERS DROP COLUMN registerNo;");
    }

    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute(cusmtomer);
        await db.execute(products);
        await db.execute(price);
        await db.execute(sales);
        await db.execute(saleProducrts);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        AppLog.info("newVersion:$newVersion oldVersion: $oldVersion");
        if (oldVersion < newVersion) {
          _updateTableAddColumnV1toV2(batch);
          _dropTableEmployeeV2(batch);
        }
        await batch.commit();
      },
    );
  }

  static Future<int> addCustomer(Customers customers) async {
    final db = await _getDB();
    AppLog.debug(customers.toJson());
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
    AppLog.debug("_________IAM_CUSTOMERS_LIST_");
    final List<Map<String, dynamic>> maps = await db.query("CUSTOMERS");
    AppLog.debug(maps);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Customers.fromJson(maps[index]));
  }

  // --------------------------PRODUCTS--------------------------------

  static Future<int> addProduct(Products products) async {
    final db = await _getDB();
    AppLog.debug("________IAM__PRODUCT__ADD____");
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
    AppLog.debug("==========checkPrice==COUNT============='$count'");
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
    AppLog.debug("_______UPDATE_________updatePrice");
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
    AppLog.debug(
        "_______selectPrice______IAM_PRICES_LIST______selectPrice________");
    List list = await db.rawQuery(
        'SELECT p.id , p.price , p.customerId, p.productId, c.name, c.phone, c.id as CUSTOMER_ID FROM PRICES p INNER JOIN CUSTOMERS c ON p.customerId = c.id WHERE c.id=?',
        [customer.id]);
    AppLog.debug(list);
    // final List<Map<String, dynamic>> dbList = await db.rawQuery("SELECT p.price, p.customerId, p.productId, c.name FROM PRICES p INNER JOIN CUSTOMERS c ON p.id = c.id");
    // AppLog.debug(await db.query("CUSTOMERS"));
    if (list.isEmpty) {
      return null;
    }
    return List.generate(list.length, (index) => Inner.fromJson(list[index]));
  }

  static Future<List<Prices>?> getAllPrice() async {
    final db = await _getDB();
    AppLog.debug("_____IAM_PRICES_LIST___________");
    final List<Map<String, dynamic>> maps = await db.query("PRICES");
    AppLog.debug(await db.query("PRICES"));
    AppLog.debug(await db.query("CUSTOMERS"));
    AppLog.debug(await db.query("PRODUCTS"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Prices.fromJson(maps[index]));
  }

// ----------------------------------SALE--------------------------------------------
  static Future<int> addSale(Sale sale) async {
    final db = await _getDB();
    AppLog.debug("________IAM__SALE__ADD____");
    final addsale = await db.insert("SALES", sale.toJson());
    AppLog.debug(sale.toJson());
    return addsale;
  }

  static Future<List<Sale>?> getAllSales() async {
    final db = await _getDB();
    AppLog.debug("_________IAM_Sale_LIST_");
    final List<Map<String, dynamic>> maps = await db.query("SALES");
    AppLog.debug(await db.query("SALES"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Sale.fromJson(maps[index]));
  }

  static Future<List<Sale>?> getSales(
      DateTime startDate, DateTime? endDate) async {
    int startTimestamp = startDate.millisecondsSinceEpoch;
    int endTimestamp = endDate!.millisecondsSinceEpoch;
    final db = await _getDB();
    AppLog.debug("_________IAM_Sale_DATE_FILTERS___");
    List list = await db.rawQuery(
        "SELECT * FROM SALES WHERE createdAt > ? and createdAt < ? ORDER BY createdAt DESC",
        [startTimestamp, endTimestamp]);
    AppLog.debug(list);
    // AppLog.debug("total: $total");
    if (list.isEmpty) {
      return null;
    }
    return List.generate(list.length, (index) => Sale.fromJson(list[index]));
  }

  static getSaleStats(DateTime startDate, DateTime? endDate) async {
    int startTimestamp = startDate.millisecondsSinceEpoch;
    int endTimestamp = endDate!.millisecondsSinceEpoch;
    final db = await _getDB();
    final stats = await db.rawQuery(
        "SELECT count(*) as count , sum(total) as total from SALES WHERE createdAt >= ? and createdAt < ?",
        [startTimestamp, endTimestamp]);
    AppLog.debug("COUNT______: $stats");
    if (stats.isEmpty) {
      return null;
    }
    return stats[0];
  }

// -------------------------------SALE-PRODUCT---------------------------------------
  static Future<int> addSaleProduct(SaleProduct saleProduct) async {
    final db = await _getDB();
    AppLog.debug("________IAM__ADD__SALE__PRODUCT");
    AppLog.debug(saleProduct.toJson());
    final addsale = await db.insert("SALE_PRODUCTS", saleProduct.toJson());
    AppLog.debug(saleProduct.toJson());
    return addsale;
  }

  static Future<List<SaleProduct>?> getAllSaleProducts(Sale sale) async {
    final db = await _getDB();
    AppLog.debug("_________IAM_Sale_LIST___PRODUCT__________");
    final List<Map<String, dynamic>> maps = await db
        .query("SALE_PRODUCTS", where: 'saleId = ?', whereArgs: [sale.id]);
    AppLog.debug(await db.query("SALE_PRODUCTS"));
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => SaleProduct.fromJson(maps[index]));
  }
}
