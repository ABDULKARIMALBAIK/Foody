import 'package:foody/moor/DaoMoor/FoodyDao.dart';
import 'package:foody/moor/DatabaseConnectorMobileDesktop.dart';
import 'package:foody/moor/DatabaseConnectorWeb.dart';
import 'package:foody/moor/tableMoor/Favorite.dart';
import 'package:foody/moor/tableMoor/FoodTable.dart';
import 'package:foody/style/platformDetect/PlatformDetector.dart';
import 'package:moor/moor.dart';

part 'FoodyDatabase.g.dart';   //Hereeeeee


@UseMoor(tables: [Favorites,FoodTables] , daos: [FoodyDao])
class FoodyDatabase extends _$FoodyDatabase{
  
  FoodyDatabase() : super(
      (PlatformDetector.isAndroid || PlatformDetector.isIOS || PlatformDetector.isMacOS)
          ? DatabaseConnectorMobileDesktop().openConnectionMobileMacOS.call() :
      (PlatformDetector.isWindows || PlatformDetector.isLinux)
          ? DatabaseConnectorMobileDesktop().openConnectionWindowsLinux.call() :
      (PlatformDetector.isWeb)
          ? DatabaseConnectorWeb().openConnectionWeb() :
      DatabaseConnectorMobileDesktop().openConnectionMobileMacOS.call() //otherwise
  );

  @override
  int get schemaVersion => 1;

}

// LazyDatabase _openConnectionMobileMacOS() {
//
//   print('build Moor database for Mobile MacOS');
//   // the LazyDatabase util lets us find the right location for the file async.
//   return LazyDatabase(() async {
//     // put the database file, called db.sqlite here, into the documents folder
//     // for your app.
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//     return VmDatabase(file, logStatements: true);
//   });
// }
//
// LazyDatabase _openConnectionWindowsLinux() {
//
//   // the LazyDatabase util lets us find the right location for the file async.
//   print('build noor database for windows linux');
//   return LazyDatabase(() async {
//     final dbFolder = await getDatabasesPath();
//     final file = File(p.join(dbFolder, 'db.sqlite'));
//     return VmDatabase(file , logStatements: true);
//   });
// }
//
// WebDatabase _openConnectionWeb() {
//   print('build noor database for Web');
//   return WebDatabase('db');
// }