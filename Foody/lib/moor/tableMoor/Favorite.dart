import 'package:moor/moor.dart';

// Declare table name as Names (add s in the end ,and name the columns)
class Favorites extends Table{
  String get tableName => 'favorite';

  IntColumn get id => integer().autoIncrement()();  //It is primary key (IntColumn + autoIncrement)
  TextColumn get userId => text().named('userId')();
  TextColumn get foodId => text().named('foodId')();
  TextColumn get blurhashImg => text().named('blurhashImg')();
  TextColumn get category_id => text().named('category_id')();
  TextColumn get code => text().named('code')();
  TextColumn get description => text().named('description')();
  TextColumn get hasDiscount => text().named('hasDiscount')();
  TextColumn get img => text().named('img')();
  TextColumn get isSale => text().named('isSale')();
  TextColumn get name => text().named('name')();
  TextColumn get newPrice => text().named('newPrice')();
  TextColumn get oldPrice => text().named('oldPrice')();
  TextColumn get star => text().named('star')();

}