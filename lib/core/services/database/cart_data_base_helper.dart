import 'package:ecommerce/constant.dart';
import 'package:ecommerce/model/cart_product_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    //define the path to the database
    //بنحدد مكان الداتا بيز من علي الموباايل بتاعنا
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //create tables
      await db.execute('''
      CREATE TABLE $tableCartProduct (
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL,
        $columnProductId TEXT NOT NULL)
       ''');
    }, onUpgrade: (Database db, int oldV, int newV) async {
      if (oldV < newV) {
        await db.execute("alter table courses add column level varchar(50) ");
      }
    });
  }

  Future<List<CartProductModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableCartProduct);
    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  insert(CartProductModel model) async {
    var dbClient = await database;
    await dbClient.insert(tableCartProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateProduct(CartProductModel model) async {
    var dbClient = await database;
    return await dbClient.update(tableCartProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }
}



//   Future<Database> createDatabase() async {
//     if (_db != null) {
//       return _db;
//     }
//     //define the path to the database
//     //بنحدد مكان الداتا بيز من علي الموباايل بتاعنا
//     String path = join(await getDatabasesPath(), 'school.db');
//     _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
//       //create tables
//       db.execute(
//           'create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours integer)');
//     }, onUpgrade: (Database db, int oldV, int newV) async {
//       if (oldV < newV) {
//         await db.execute("alter table courses add column level varchar(50) ");
//       }
//     });
//     return _db;
//   }

//   Future<int> createCourse(Course course) async {
//     Database db = await createDatabase();
//     //db.rawInsert('insert into courses value')
//     return db.insert('courses', course.toMap());
//   }

//   Future<List> allCourses() async {
//     Database db = await createDatabase();
//     //db.rawQuery('select * from courses');
//     return db.query('courses');
//   }

//   Future<int> delete(int id) async {
//     Database db = await createDatabase();
//     return db.delete('courses', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> courseUpdate(Course course) async {
//     Database db = await createDatabase();
//     return await db.update('courses', course.toMap(),
//         where: 'id = ?', whereArgs: [course.id]);
//   }
// }
