import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> createtables() async {
  // Use the ffi web factory in web apps (flutter or dart)
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase('epal.db');
  print(db.isOpen);
  db.execute(
      "CREATE TABLE IF NOT EXISTS zone (Zone_ID INTEGER PRIMARY KEY, Zone_Nom TEXT, Zone_Type TEXT)");
  db.execute(
      "CREATE TABLE IF NOT EXISTS parc (NumParc INTEGER PRIMARY KEY, NomParc TEXT)");
  db.execute(
      "CREATE TABLE IF NOT EXISTS conteneur (Conteneur_ID INTEGER PRIMARY KEY, Conteneur_Type TEXT, Conteneur_Poids REAL,Cont_Status TEXT)");
  db.execute(
      "CREATE TABLE IF NOT EXISTS visite (Conteneur_ID INTEGER PRIMARY KEY, Conteneur_Type TEXT, Conteneur_Poids REAL,Cont_Status TEXT)");

  db.execute(
      "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, Nom TEXT, Prenom TEXT,Role TEXT,Adresse String , Tel INTEGER,MotDePasse TEXT,Shift TEXT)");
  db.execute(
      "CREATE TABLE IF NOT EXISTS admin (id INTEGER PRIMARY KEY, Nom TEXT, Prenom TEXT,Role TEXT,Adresse String , Tel INTEGER,MotDePasse TEXT,Shift TEXT)");

  var sqliteVersion =
      (await db.rawQuery('select sqlite_version()')).first.values.first;
  print(sqliteVersion); // should print 3.39.3
}
