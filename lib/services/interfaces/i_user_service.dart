
import 'package:flutter/material.dart';
import 'package:movegui/models/user_model.dart';

abstract class IUserService {
  Future<UserModel?> getByUsername(String username);
  Future<void> registerWithEmail(UserModel model);
  Future<void> registerWithPhone(BuildContext context, UserModel model);
  Future<void> registerWithGoogle(UserModel model);
  Future<void> registerWithAppleId(UserModel model);
  Future<void> update(UserModel model);
  Future<UserModel?> getByEmail(String email);
  Future<UserModel?> getByPhone(String phone);
  Future<void> signOut();


}