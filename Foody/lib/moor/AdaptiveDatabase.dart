// import 'dart:ffi';
// import 'dart:io';
// import 'package:sqlite3/sqlite3.dart';
// import 'package:sqlite3/open.dart';
//
//
// class AdaptiveDatabase {
//
//   //Init Linux Opening Moor Database
//   void openLinuxMoorDatabase() {
//
//     open.overrideFor(OperatingSystem.linux, _openOnLinux);
//
//     final db = sqlite3.openInMemory();
//     db.dispose();
//   }
//
//   DynamicLibrary _openOnLinux() {
//     final script = File(Platform.script.toFilePath());
//     final libraryNextToScript = File('${script.path}/sqlite3.so');
//     return DynamicLibrary.open(libraryNextToScript.path);
//   }
//
//
//
//
//   //Init Windows Opening Moor Database
//   void openWindowsMoorDatabase() {
//
//     open.overrideFor(OperatingSystem.windows, _openOnWindows);
//
//     final db = sqlite3.openInMemory();
//     db.dispose();
//   }
//
//   DynamicLibrary _openOnWindows() {
//     final script = File(Platform.script.toFilePath());
//     final libraryNextToScript = File('${script.path}/sqlite3.dll');
//     return DynamicLibrary.open(libraryNextToScript.path);
//   }
//
//
// }
//
//
