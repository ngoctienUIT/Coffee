import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/store_dao.dart';
import '../dao/user_dao.dart';
import '../entity/store_entity.dart';
import '../entity/user_entity.dart';

part 'coffee_database.g.dart';

@Database(version: 1, entities: [UserEntity, StoreEntity])
abstract class CoffeeDatabase extends FloorDatabase {
  UserDao get userDao;

  StoreDao get storeDao;
}
