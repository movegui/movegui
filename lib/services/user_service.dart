import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/screens/auth/otp_verification_scxreen.dart';
import 'package:movegui/services/interfaces/i_user_service.dart';
import 'package:movegui/services/model_service.dart';

class UserService extends ModelService<UserModel> implements IUserService {
  @override
  Future<void> addModel(UserModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
  }

  @override
  Future<List<UserModel>> allModels() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(getCollectionName()).get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  Future<List<UserModel>> getByName(String name) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('name', isEqualTo: name)
            .get();

    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  @override
  String getCollectionName() {
    return "users";
  }

  @override
  Future<UserModel?> getByUsername(String username) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('username', isEqualTo: username)
            .get();

    if (snapshot.docs.isEmpty) return null;

    return UserModel.fromJson(snapshot.docs.first.data());

    //  return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  @override
  Future<void> registerWithAppleId(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<void> registerWithEmail(UserModel model) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: model.personModel!.email!,
      password: model.password!,
    );
    await addModel(model);
  }

  @override
  Future<void> registerWithGoogle(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<void> registerWithPhone(BuildContext context, UserModel model) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: model.personModel!.phone,
      verificationCompleted: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        print(e.message);
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => OtpVerificationScreen(
                  verificationId: verificationId,
                  phoneNumber: model.personModel!.phone!,
                ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  @override
  Future<UserModel?> getByEmail(String email) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('email', isEqualTo: email)
            .get();

    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromJson(snapshot.docs.first.data());
    // return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  @override
  Future<UserModel?> getByPhone(String phone) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('phone', isEqualTo: phone)
            .get();

    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromJson(snapshot.docs.first.data());
    // return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).first;
  }

  Future<UserModel> getById(String id) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .doc(id)
            .get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("User not found");
    }

    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> update(UserModel model) async {
    return FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .update(model.toJson());
  }

  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

}
