import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> database() async {
  // Use the ffi web factory in web apps (flutter or dart)
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase('epal.db');
  print(db.isOpen);
  //db.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
  //await db.insert('users', {'name': 'Bob', 'age': 23});
  //await db.insert('users', {'name': 'Alice', 'age': 32});
  //await db.insert('users', {'name': 'Joe', 'age': 21});
  var users = await db.query('users');
  print(users);
  var sqliteVersion =
      (await db.rawQuery('select sqlite_version()')).first.values.first;
  print(sqliteVersion); // should print 3.39.3
}
