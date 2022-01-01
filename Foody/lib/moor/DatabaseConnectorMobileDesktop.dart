// import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart' show getDatabasesPath;
// import 'package:path/path.dart' as p;
// import 'dart:io';

class DatabaseConnectorMobileDesktop {

  FlutterQueryExecutor openConnectionMobileMacOS() {  //LazyDatabase

    print('build Moor database for Mobile MacOS');

    return  FlutterQueryExecutor.inDatabaseFolder(
        path: "db.sqlite", logStatements: true);




    // // the LazyDatabase util lets us find the right location for the file async.
    // return LazyDatabase(() async {
    //   // put the database file, called db.sqlite here, into the documents folder
    //   // for your app.
    //   final dbFolder = await getApplicationDocumentsDirectory();
    //   final file = File(p.join(dbFolder.path, 'db.sqlite'));
    //   return VmDatabase(file, logStatements: true);
    // });
  }

  FlutterQueryExecutor openConnectionWindowsLinux() {

    print('build noor database for windows linux');
    return  FlutterQueryExecutor.inDatabaseFolder(
        path: "db.sqlite", logStatements: true);


    // the LazyDatabase util lets us find the right location for the file async.
    //
    // return LazyDatabase(() async {
    //   final dbFolder = await getDatabasesPath();
    //   final file = File(p.join(dbFolder, 'db.sqlite'));
    //   return VmDatabase(file , logStatements: true);
    // });
  }

}