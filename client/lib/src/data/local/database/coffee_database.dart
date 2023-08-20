import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/user_dao.dart';
import '../entity/user_entity.dart';

part 'coffee_database.g.dart';

@Database(version: 1, entities: [UserEntity])
abstract class CoffeeDatabase extends FloorDatabase {
  UserDao get userDao;
}
