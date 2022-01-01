// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodyDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final String userId;
  final String foodId;
  final String blurhashImg;
  final String category_id;
  final String code;
  final String description;
  final String hasDiscount;
  final String img;
  final String isSale;
  final String name;
  final String newPrice;
  final String oldPrice;
  final String star;
  Favorite(
      {required this.id,
      required this.userId,
      required this.foodId,
      required this.blurhashImg,
      required this.category_id,
      required this.code,
      required this.description,
      required this.hasDiscount,
      required this.img,
      required this.isSale,
      required this.name,
      required this.newPrice,
      required this.oldPrice,
      required this.star});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Favorite(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}userId'])!,
      foodId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}foodId'])!,
      blurhashImg: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}blurhashImg'])!,
      category_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      hasDiscount: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hasDiscount'])!,
      img: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}img'])!,
      isSale: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}isSale'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      newPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}newPrice'])!,
      oldPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}oldPrice'])!,
      star: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}star'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['userId'] = Variable<String>(userId);
    map['foodId'] = Variable<String>(foodId);
    map['blurhashImg'] = Variable<String>(blurhashImg);
    map['category_id'] = Variable<String>(category_id);
    map['code'] = Variable<String>(code);
    map['description'] = Variable<String>(description);
    map['hasDiscount'] = Variable<String>(hasDiscount);
    map['img'] = Variable<String>(img);
    map['isSale'] = Variable<String>(isSale);
    map['name'] = Variable<String>(name);
    map['newPrice'] = Variable<String>(newPrice);
    map['oldPrice'] = Variable<String>(oldPrice);
    map['star'] = Variable<String>(star);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      blurhashImg: serializer.fromJson<String>(json['blurhashImg']),
      category_id: serializer.fromJson<String>(json['category_id']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String>(json['description']),
      hasDiscount: serializer.fromJson<String>(json['hasDiscount']),
      img: serializer.fromJson<String>(json['img']),
      isSale: serializer.fromJson<String>(json['isSale']),
      name: serializer.fromJson<String>(json['name']),
      newPrice: serializer.fromJson<String>(json['newPrice']),
      oldPrice: serializer.fromJson<String>(json['oldPrice']),
      star: serializer.fromJson<String>(json['star']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodId': serializer.toJson<String>(foodId),
      'blurhashImg': serializer.toJson<String>(blurhashImg),
      'category_id': serializer.toJson<String>(category_id),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String>(description),
      'hasDiscount': serializer.toJson<String>(hasDiscount),
      'img': serializer.toJson<String>(img),
      'isSale': serializer.toJson<String>(isSale),
      'name': serializer.toJson<String>(name),
      'newPrice': serializer.toJson<String>(newPrice),
      'oldPrice': serializer.toJson<String>(oldPrice),
      'star': serializer.toJson<String>(star),
    };
  }

  Favorite copyWith(
          {int? id,
          String? userId,
          String? foodId,
          String? blurhashImg,
          String? category_id,
          String? code,
          String? description,
          String? hasDiscount,
          String? img,
          String? isSale,
          String? name,
          String? newPrice,
          String? oldPrice,
          String? star}) =>
      Favorite(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        blurhashImg: blurhashImg ?? this.blurhashImg,
        category_id: category_id ?? this.category_id,
        code: code ?? this.code,
        description: description ?? this.description,
        hasDiscount: hasDiscount ?? this.hasDiscount,
        img: img ?? this.img,
        isSale: isSale ?? this.isSale,
        name: name ?? this.name,
        newPrice: newPrice ?? this.newPrice,
        oldPrice: oldPrice ?? this.oldPrice,
        star: star ?? this.star,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('blurhashImg: $blurhashImg, ')
          ..write('category_id: $category_id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('hasDiscount: $hasDiscount, ')
          ..write('img: $img, ')
          ..write('isSale: $isSale, ')
          ..write('name: $name, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('star: $star')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              foodId.hashCode,
              $mrjc(
                  blurhashImg.hashCode,
                  $mrjc(
                      category_id.hashCode,
                      $mrjc(
                          code.hashCode,
                          $mrjc(
                              description.hashCode,
                              $mrjc(
                                  hasDiscount.hashCode,
                                  $mrjc(
                                      img.hashCode,
                                      $mrjc(
                                          isSale.hashCode,
                                          $mrjc(
                                              name.hashCode,
                                              $mrjc(
                                                  newPrice.hashCode,
                                                  $mrjc(oldPrice.hashCode,
                                                      star.hashCode))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.blurhashImg == this.blurhashImg &&
          other.category_id == this.category_id &&
          other.code == this.code &&
          other.description == this.description &&
          other.hasDiscount == this.hasDiscount &&
          other.img == this.img &&
          other.isSale == this.isSale &&
          other.name == this.name &&
          other.newPrice == this.newPrice &&
          other.oldPrice == this.oldPrice &&
          other.star == this.star);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> foodId;
  final Value<String> blurhashImg;
  final Value<String> category_id;
  final Value<String> code;
  final Value<String> description;
  final Value<String> hasDiscount;
  final Value<String> img;
  final Value<String> isSale;
  final Value<String> name;
  final Value<String> newPrice;
  final Value<String> oldPrice;
  final Value<String> star;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.blurhashImg = const Value.absent(),
    this.category_id = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.hasDiscount = const Value.absent(),
    this.img = const Value.absent(),
    this.isSale = const Value.absent(),
    this.name = const Value.absent(),
    this.newPrice = const Value.absent(),
    this.oldPrice = const Value.absent(),
    this.star = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String foodId,
    required String blurhashImg,
    required String category_id,
    required String code,
    required String description,
    required String hasDiscount,
    required String img,
    required String isSale,
    required String name,
    required String newPrice,
    required String oldPrice,
    required String star,
  })  : userId = Value(userId),
        foodId = Value(foodId),
        blurhashImg = Value(blurhashImg),
        category_id = Value(category_id),
        code = Value(code),
        description = Value(description),
        hasDiscount = Value(hasDiscount),
        img = Value(img),
        isSale = Value(isSale),
        name = Value(name),
        newPrice = Value(newPrice),
        oldPrice = Value(oldPrice),
        star = Value(star);
  static Insertable<Favorite> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? foodId,
    Expression<String>? blurhashImg,
    Expression<String>? category_id,
    Expression<String>? code,
    Expression<String>? description,
    Expression<String>? hasDiscount,
    Expression<String>? img,
    Expression<String>? isSale,
    Expression<String>? name,
    Expression<String>? newPrice,
    Expression<String>? oldPrice,
    Expression<String>? star,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (foodId != null) 'foodId': foodId,
      if (blurhashImg != null) 'blurhashImg': blurhashImg,
      if (category_id != null) 'category_id': category_id,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (hasDiscount != null) 'hasDiscount': hasDiscount,
      if (img != null) 'img': img,
      if (isSale != null) 'isSale': isSale,
      if (name != null) 'name': name,
      if (newPrice != null) 'newPrice': newPrice,
      if (oldPrice != null) 'oldPrice': oldPrice,
      if (star != null) 'star': star,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? foodId,
      Value<String>? blurhashImg,
      Value<String>? category_id,
      Value<String>? code,
      Value<String>? description,
      Value<String>? hasDiscount,
      Value<String>? img,
      Value<String>? isSale,
      Value<String>? name,
      Value<String>? newPrice,
      Value<String>? oldPrice,
      Value<String>? star}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      blurhashImg: blurhashImg ?? this.blurhashImg,
      category_id: category_id ?? this.category_id,
      code: code ?? this.code,
      description: description ?? this.description,
      hasDiscount: hasDiscount ?? this.hasDiscount,
      img: img ?? this.img,
      isSale: isSale ?? this.isSale,
      name: name ?? this.name,
      newPrice: newPrice ?? this.newPrice,
      oldPrice: oldPrice ?? this.oldPrice,
      star: star ?? this.star,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['userId'] = Variable<String>(userId.value);
    }
    if (foodId.present) {
      map['foodId'] = Variable<String>(foodId.value);
    }
    if (blurhashImg.present) {
      map['blurhashImg'] = Variable<String>(blurhashImg.value);
    }
    if (category_id.present) {
      map['category_id'] = Variable<String>(category_id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (hasDiscount.present) {
      map['hasDiscount'] = Variable<String>(hasDiscount.value);
    }
    if (img.present) {
      map['img'] = Variable<String>(img.value);
    }
    if (isSale.present) {
      map['isSale'] = Variable<String>(isSale.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (newPrice.present) {
      map['newPrice'] = Variable<String>(newPrice.value);
    }
    if (oldPrice.present) {
      map['oldPrice'] = Variable<String>(oldPrice.value);
    }
    if (star.present) {
      map['star'] = Variable<String>(star.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('blurhashImg: $blurhashImg, ')
          ..write('category_id: $category_id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('hasDiscount: $hasDiscount, ')
          ..write('img: $img, ')
          ..write('isSale: $isSale, ')
          ..write('name: $name, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('star: $star')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FavoritesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'userId', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  late final GeneratedColumn<String?> foodId = GeneratedColumn<String?>(
      'foodId', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _blurhashImgMeta =
      const VerificationMeta('blurhashImg');
  late final GeneratedColumn<String?> blurhashImg = GeneratedColumn<String?>(
      'blurhashImg', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _category_idMeta =
      const VerificationMeta('category_id');
  late final GeneratedColumn<String?> category_id = GeneratedColumn<String?>(
      'category_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _hasDiscountMeta =
      const VerificationMeta('hasDiscount');
  late final GeneratedColumn<String?> hasDiscount = GeneratedColumn<String?>(
      'hasDiscount', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _imgMeta = const VerificationMeta('img');
  late final GeneratedColumn<String?> img = GeneratedColumn<String?>(
      'img', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _isSaleMeta = const VerificationMeta('isSale');
  late final GeneratedColumn<String?> isSale = GeneratedColumn<String?>(
      'isSale', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _newPriceMeta = const VerificationMeta('newPrice');
  late final GeneratedColumn<String?> newPrice = GeneratedColumn<String?>(
      'newPrice', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _oldPriceMeta = const VerificationMeta('oldPrice');
  late final GeneratedColumn<String?> oldPrice = GeneratedColumn<String?>(
      'oldPrice', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _starMeta = const VerificationMeta('star');
  late final GeneratedColumn<String?> star = GeneratedColumn<String?>(
      'star', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodId,
        blurhashImg,
        category_id,
        code,
        description,
        hasDiscount,
        img,
        isSale,
        name,
        newPrice,
        oldPrice,
        star
      ];
  @override
  String get aliasedName => _alias ?? 'favorite';
  @override
  String get actualTableName => 'favorite';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('userId')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['userId']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('foodId')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['foodId']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('blurhashImg')) {
      context.handle(
          _blurhashImgMeta,
          blurhashImg.isAcceptableOrUnknown(
              data['blurhashImg']!, _blurhashImgMeta));
    } else if (isInserting) {
      context.missing(_blurhashImgMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _category_idMeta,
          category_id.isAcceptableOrUnknown(
              data['category_id']!, _category_idMeta));
    } else if (isInserting) {
      context.missing(_category_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('hasDiscount')) {
      context.handle(
          _hasDiscountMeta,
          hasDiscount.isAcceptableOrUnknown(
              data['hasDiscount']!, _hasDiscountMeta));
    } else if (isInserting) {
      context.missing(_hasDiscountMeta);
    }
    if (data.containsKey('img')) {
      context.handle(
          _imgMeta, img.isAcceptableOrUnknown(data['img']!, _imgMeta));
    } else if (isInserting) {
      context.missing(_imgMeta);
    }
    if (data.containsKey('isSale')) {
      context.handle(_isSaleMeta,
          isSale.isAcceptableOrUnknown(data['isSale']!, _isSaleMeta));
    } else if (isInserting) {
      context.missing(_isSaleMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('newPrice')) {
      context.handle(_newPriceMeta,
          newPrice.isAcceptableOrUnknown(data['newPrice']!, _newPriceMeta));
    } else if (isInserting) {
      context.missing(_newPriceMeta);
    }
    if (data.containsKey('oldPrice')) {
      context.handle(_oldPriceMeta,
          oldPrice.isAcceptableOrUnknown(data['oldPrice']!, _oldPriceMeta));
    } else if (isInserting) {
      context.missing(_oldPriceMeta);
    }
    if (data.containsKey('star')) {
      context.handle(
          _starMeta, star.isAcceptableOrUnknown(data['star']!, _starMeta));
    } else if (isInserting) {
      context.missing(_starMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Favorite.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(_db, alias);
  }
}

class FoodTable extends DataClass implements Insertable<FoodTable> {
  final int id;
  final String userId;
  final String foodId;
  final String blurhashImg;
  final String category_id;
  final String code;
  final String description;
  final String hasDiscount;
  final String img;
  final String isSale;
  final String name;
  final String newPrice;
  final String oldPrice;
  final String star;
  int quantity = 0;
  final int size;
  final String spices;
  FoodTable(
      {required this.id,
      required this.userId,
      required this.foodId,
      required this.blurhashImg,
      required this.category_id,
      required this.code,
      required this.description,
      required this.hasDiscount,
      required this.img,
      required this.isSale,
      required this.name,
      required this.newPrice,
      required this.oldPrice,
      required this.star,
      required this.quantity,
      required this.size,
      required this.spices});
  factory FoodTable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FoodTable(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}userId'])!,
      foodId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}foodId'])!,
      blurhashImg: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}blurhashImg'])!,
      category_id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      hasDiscount: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hasDiscount'])!,
      img: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}img'])!,
      isSale: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}isSale'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      newPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}newPrice'])!,
      oldPrice: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}oldPrice'])!,
      star: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}star'])!,
      quantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity'])!,
      size: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}size'])!,
      spices: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}spices'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['userId'] = Variable<String>(userId);
    map['foodId'] = Variable<String>(foodId);
    map['blurhashImg'] = Variable<String>(blurhashImg);
    map['category_id'] = Variable<String>(category_id);
    map['code'] = Variable<String>(code);
    map['description'] = Variable<String>(description);
    map['hasDiscount'] = Variable<String>(hasDiscount);
    map['img'] = Variable<String>(img);
    map['isSale'] = Variable<String>(isSale);
    map['name'] = Variable<String>(name);
    map['newPrice'] = Variable<String>(newPrice);
    map['oldPrice'] = Variable<String>(oldPrice);
    map['star'] = Variable<String>(star);
    map['quantity'] = Variable<int>(quantity);
    map['size'] = Variable<int>(size);
    map['spices'] = Variable<String>(spices);
    return map;
  }

  FoodTablesCompanion toCompanion(bool nullToAbsent) {
    return FoodTablesCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
      quantity: Value(quantity),
      size: Value(size),
      spices: Value(spices),
    );
  }

  factory FoodTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FoodTable(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      blurhashImg: serializer.fromJson<String>(json['blurhashImg']),
      category_id: serializer.fromJson<String>(json['category_id']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String>(json['description']),
      hasDiscount: serializer.fromJson<String>(json['hasDiscount']),
      img: serializer.fromJson<String>(json['img']),
      isSale: serializer.fromJson<String>(json['isSale']),
      name: serializer.fromJson<String>(json['name']),
      newPrice: serializer.fromJson<String>(json['newPrice']),
      oldPrice: serializer.fromJson<String>(json['oldPrice']),
      star: serializer.fromJson<String>(json['star']),
      quantity: serializer.fromJson<int>(json['quantity']),
      size: serializer.fromJson<int>(json['size']),
      spices: serializer.fromJson<String>(json['spices']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodId': serializer.toJson<String>(foodId),
      'blurhashImg': serializer.toJson<String>(blurhashImg),
      'category_id': serializer.toJson<String>(category_id),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String>(description),
      'hasDiscount': serializer.toJson<String>(hasDiscount),
      'img': serializer.toJson<String>(img),
      'isSale': serializer.toJson<String>(isSale),
      'name': serializer.toJson<String>(name),
      'newPrice': serializer.toJson<String>(newPrice),
      'oldPrice': serializer.toJson<String>(oldPrice),
      'star': serializer.toJson<String>(star),
      'quantity': serializer.toJson<int>(quantity),
      'size': serializer.toJson<int>(size),
      'spices': serializer.toJson<String>(spices),
    };
  }

  FoodTable copyWith(
          {int? id,
          String? userId,
          String? foodId,
          String? blurhashImg,
          String? category_id,
          String? code,
          String? description,
          String? hasDiscount,
          String? img,
          String? isSale,
          String? name,
          String? newPrice,
          String? oldPrice,
          String? star,
          int? quantity,
          int? size,
          String? spices}) =>
      FoodTable(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodId: foodId ?? this.foodId,
        blurhashImg: blurhashImg ?? this.blurhashImg,
        category_id: category_id ?? this.category_id,
        code: code ?? this.code,
        description: description ?? this.description,
        hasDiscount: hasDiscount ?? this.hasDiscount,
        img: img ?? this.img,
        isSale: isSale ?? this.isSale,
        name: name ?? this.name,
        newPrice: newPrice ?? this.newPrice,
        oldPrice: oldPrice ?? this.oldPrice,
        star: star ?? this.star,
        quantity: quantity ?? this.quantity,
        size: size ?? this.size,
        spices: spices ?? this.spices,
      );
  @override
  String toString() {
    return (StringBuffer('FoodTable(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('blurhashImg: $blurhashImg, ')
          ..write('category_id: $category_id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('hasDiscount: $hasDiscount, ')
          ..write('img: $img, ')
          ..write('isSale: $isSale, ')
          ..write('name: $name, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('star: $star, ')
          ..write('quantity: $quantity, ')
          ..write('size: $size, ')
          ..write('spices: $spices')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              foodId.hashCode,
              $mrjc(
                  blurhashImg.hashCode,
                  $mrjc(
                      category_id.hashCode,
                      $mrjc(
                          code.hashCode,
                          $mrjc(
                              description.hashCode,
                              $mrjc(
                                  hasDiscount.hashCode,
                                  $mrjc(
                                      img.hashCode,
                                      $mrjc(
                                          isSale.hashCode,
                                          $mrjc(
                                              name.hashCode,
                                              $mrjc(
                                                  newPrice.hashCode,
                                                  $mrjc(
                                                      oldPrice.hashCode,
                                                      $mrjc(
                                                          star.hashCode,
                                                          $mrjc(
                                                              quantity.hashCode,
                                                              $mrjc(
                                                                  size.hashCode,
                                                                  spices
                                                                      .hashCode)))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodTable &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodId == this.foodId &&
          other.blurhashImg == this.blurhashImg &&
          other.category_id == this.category_id &&
          other.code == this.code &&
          other.description == this.description &&
          other.hasDiscount == this.hasDiscount &&
          other.img == this.img &&
          other.isSale == this.isSale &&
          other.name == this.name &&
          other.newPrice == this.newPrice &&
          other.oldPrice == this.oldPrice &&
          other.star == this.star &&
          other.quantity == this.quantity &&
          other.size == this.size &&
          other.spices == this.spices);
}

class FoodTablesCompanion extends UpdateCompanion<FoodTable> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> foodId;
  final Value<String> blurhashImg;
  final Value<String> category_id;
  final Value<String> code;
  final Value<String> description;
  final Value<String> hasDiscount;
  final Value<String> img;
  final Value<String> isSale;
  final Value<String> name;
  final Value<String> newPrice;
  final Value<String> oldPrice;
  final Value<String> star;
  final Value<int> quantity;
  final Value<int> size;
  final Value<String> spices;
  const FoodTablesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.blurhashImg = const Value.absent(),
    this.category_id = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.hasDiscount = const Value.absent(),
    this.img = const Value.absent(),
    this.isSale = const Value.absent(),
    this.name = const Value.absent(),
    this.newPrice = const Value.absent(),
    this.oldPrice = const Value.absent(),
    this.star = const Value.absent(),
    this.quantity = const Value.absent(),
    this.size = const Value.absent(),
    this.spices = const Value.absent(),
  });
  FoodTablesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String foodId,
    required String blurhashImg,
    required String category_id,
    required String code,
    required String description,
    required String hasDiscount,
    required String img,
    required String isSale,
    required String name,
    required String newPrice,
    required String oldPrice,
    required String star,
    required int quantity,
    required int size,
    required String spices,
  })  : userId = Value(userId),
        foodId = Value(foodId),
        blurhashImg = Value(blurhashImg),
        category_id = Value(category_id),
        code = Value(code),
        description = Value(description),
        hasDiscount = Value(hasDiscount),
        img = Value(img),
        isSale = Value(isSale),
        name = Value(name),
        newPrice = Value(newPrice),
        oldPrice = Value(oldPrice),
        star = Value(star),
        quantity = Value(quantity),
        size = Value(size),
        spices = Value(spices);
  static Insertable<FoodTable> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? foodId,
    Expression<String>? blurhashImg,
    Expression<String>? category_id,
    Expression<String>? code,
    Expression<String>? description,
    Expression<String>? hasDiscount,
    Expression<String>? img,
    Expression<String>? isSale,
    Expression<String>? name,
    Expression<String>? newPrice,
    Expression<String>? oldPrice,
    Expression<String>? star,
    Expression<int>? quantity,
    Expression<int>? size,
    Expression<String>? spices,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (foodId != null) 'foodId': foodId,
      if (blurhashImg != null) 'blurhashImg': blurhashImg,
      if (category_id != null) 'category_id': category_id,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (hasDiscount != null) 'hasDiscount': hasDiscount,
      if (img != null) 'img': img,
      if (isSale != null) 'isSale': isSale,
      if (name != null) 'name': name,
      if (newPrice != null) 'newPrice': newPrice,
      if (oldPrice != null) 'oldPrice': oldPrice,
      if (star != null) 'star': star,
      if (quantity != null) 'quantity': quantity,
      if (size != null) 'size': size,
      if (spices != null) 'spices': spices,
    });
  }

  FoodTablesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? foodId,
      Value<String>? blurhashImg,
      Value<String>? category_id,
      Value<String>? code,
      Value<String>? description,
      Value<String>? hasDiscount,
      Value<String>? img,
      Value<String>? isSale,
      Value<String>? name,
      Value<String>? newPrice,
      Value<String>? oldPrice,
      Value<String>? star,
      Value<int>? quantity,
      Value<int>? size,
      Value<String>? spices}) {
    return FoodTablesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      blurhashImg: blurhashImg ?? this.blurhashImg,
      category_id: category_id ?? this.category_id,
      code: code ?? this.code,
      description: description ?? this.description,
      hasDiscount: hasDiscount ?? this.hasDiscount,
      img: img ?? this.img,
      isSale: isSale ?? this.isSale,
      name: name ?? this.name,
      newPrice: newPrice ?? this.newPrice,
      oldPrice: oldPrice ?? this.oldPrice,
      star: star ?? this.star,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      spices: spices ?? this.spices,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['userId'] = Variable<String>(userId.value);
    }
    if (foodId.present) {
      map['foodId'] = Variable<String>(foodId.value);
    }
    if (blurhashImg.present) {
      map['blurhashImg'] = Variable<String>(blurhashImg.value);
    }
    if (category_id.present) {
      map['category_id'] = Variable<String>(category_id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (hasDiscount.present) {
      map['hasDiscount'] = Variable<String>(hasDiscount.value);
    }
    if (img.present) {
      map['img'] = Variable<String>(img.value);
    }
    if (isSale.present) {
      map['isSale'] = Variable<String>(isSale.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (newPrice.present) {
      map['newPrice'] = Variable<String>(newPrice.value);
    }
    if (oldPrice.present) {
      map['oldPrice'] = Variable<String>(oldPrice.value);
    }
    if (star.present) {
      map['star'] = Variable<String>(star.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (spices.present) {
      map['spices'] = Variable<String>(spices.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodTablesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodId: $foodId, ')
          ..write('blurhashImg: $blurhashImg, ')
          ..write('category_id: $category_id, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('hasDiscount: $hasDiscount, ')
          ..write('img: $img, ')
          ..write('isSale: $isSale, ')
          ..write('name: $name, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('star: $star, ')
          ..write('quantity: $quantity, ')
          ..write('size: $size, ')
          ..write('spices: $spices')
          ..write(')'))
        .toString();
  }
}

class $FoodTablesTable extends FoodTables
    with TableInfo<$FoodTablesTable, FoodTable> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FoodTablesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'userId', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  late final GeneratedColumn<String?> foodId = GeneratedColumn<String?>(
      'foodId', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _blurhashImgMeta =
      const VerificationMeta('blurhashImg');
  late final GeneratedColumn<String?> blurhashImg = GeneratedColumn<String?>(
      'blurhashImg', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _category_idMeta =
      const VerificationMeta('category_id');
  late final GeneratedColumn<String?> category_id = GeneratedColumn<String?>(
      'category_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _hasDiscountMeta =
      const VerificationMeta('hasDiscount');
  late final GeneratedColumn<String?> hasDiscount = GeneratedColumn<String?>(
      'hasDiscount', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _imgMeta = const VerificationMeta('img');
  late final GeneratedColumn<String?> img = GeneratedColumn<String?>(
      'img', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _isSaleMeta = const VerificationMeta('isSale');
  late final GeneratedColumn<String?> isSale = GeneratedColumn<String?>(
      'isSale', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _newPriceMeta = const VerificationMeta('newPrice');
  late final GeneratedColumn<String?> newPrice = GeneratedColumn<String?>(
      'newPrice', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _oldPriceMeta = const VerificationMeta('oldPrice');
  late final GeneratedColumn<String?> oldPrice = GeneratedColumn<String?>(
      'oldPrice', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _starMeta = const VerificationMeta('star');
  late final GeneratedColumn<String?> star = GeneratedColumn<String?>(
      'star', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  late final GeneratedColumn<int?> quantity = GeneratedColumn<int?>(
      'quantity', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  late final GeneratedColumn<int?> size = GeneratedColumn<int?>(
      'size', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _spicesMeta = const VerificationMeta('spices');
  late final GeneratedColumn<String?> spices = GeneratedColumn<String?>(
      'spices', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodId,
        blurhashImg,
        category_id,
        code,
        description,
        hasDiscount,
        img,
        isSale,
        name,
        newPrice,
        oldPrice,
        star,
        quantity,
        size,
        spices
      ];
  @override
  String get aliasedName => _alias ?? 'food_table';
  @override
  String get actualTableName => 'food_table';
  @override
  VerificationContext validateIntegrity(Insertable<FoodTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('userId')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['userId']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('foodId')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['foodId']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('blurhashImg')) {
      context.handle(
          _blurhashImgMeta,
          blurhashImg.isAcceptableOrUnknown(
              data['blurhashImg']!, _blurhashImgMeta));
    } else if (isInserting) {
      context.missing(_blurhashImgMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _category_idMeta,
          category_id.isAcceptableOrUnknown(
              data['category_id']!, _category_idMeta));
    } else if (isInserting) {
      context.missing(_category_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('hasDiscount')) {
      context.handle(
          _hasDiscountMeta,
          hasDiscount.isAcceptableOrUnknown(
              data['hasDiscount']!, _hasDiscountMeta));
    } else if (isInserting) {
      context.missing(_hasDiscountMeta);
    }
    if (data.containsKey('img')) {
      context.handle(
          _imgMeta, img.isAcceptableOrUnknown(data['img']!, _imgMeta));
    } else if (isInserting) {
      context.missing(_imgMeta);
    }
    if (data.containsKey('isSale')) {
      context.handle(_isSaleMeta,
          isSale.isAcceptableOrUnknown(data['isSale']!, _isSaleMeta));
    } else if (isInserting) {
      context.missing(_isSaleMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('newPrice')) {
      context.handle(_newPriceMeta,
          newPrice.isAcceptableOrUnknown(data['newPrice']!, _newPriceMeta));
    } else if (isInserting) {
      context.missing(_newPriceMeta);
    }
    if (data.containsKey('oldPrice')) {
      context.handle(_oldPriceMeta,
          oldPrice.isAcceptableOrUnknown(data['oldPrice']!, _oldPriceMeta));
    } else if (isInserting) {
      context.missing(_oldPriceMeta);
    }
    if (data.containsKey('star')) {
      context.handle(
          _starMeta, star.isAcceptableOrUnknown(data['star']!, _starMeta));
    } else if (isInserting) {
      context.missing(_starMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('spices')) {
      context.handle(_spicesMeta,
          spices.isAcceptableOrUnknown(data['spices']!, _spicesMeta));
    } else if (isInserting) {
      context.missing(_spicesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FoodTable.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FoodTablesTable createAlias(String alias) {
    return $FoodTablesTable(_db, alias);
  }
}

abstract class _$FoodyDatabase extends GeneratedDatabase {
  _$FoodyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $FoodTablesTable foodTables = $FoodTablesTable(this);
  late final FoodyDao foodyDao = FoodyDao(this as FoodyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favorites, foodTables];
}
