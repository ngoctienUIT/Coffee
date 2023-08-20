import 'package:floor/floor.dart';

import '../entity/user_entity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM User WHERE id = :id')
  Stream<UserEntity?> findUserById(String id);

  @insert
  Future<void> insertUser(UserEntity user);
  
  @update
  Future<void> updateUser(UserEntity user);
}
