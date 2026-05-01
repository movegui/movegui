import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/person_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/screens/auth/otp_verification_scxreen.dart';
import 'package:movegui/services/interfaces/i_user_service.dart';
import 'package:movegui/services/model_service.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:uuid/uuid.dart';

class UserService extends ModelService<UserModel> implements IUserService {
  final auth = FirebaseAuth.instance;
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
  Future<UserModel?> registerWithEmail(BuildContext context, UserModel model, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.personModel!.email!,
            password: password,
          );
      User? user = credential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      if(user!.emailVerified){
        model.isVerified = true;
      }
      await addModel(model);
      return model;
    } on FirebaseException catch (e) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        AppLocalizations.of(context)!.error_register_with_phone_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
    return null;
  }

  @override
  Future<void> registerWithGoogle(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<void> registerWithPhone(BuildContext context, UserModel user) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: user.personModel!.phone,
      verificationCompleted: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_register_with_phone_title,
          AppLocalizations.of(context)!.error_register_with_phone_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => OtpVerificationScreen(
                  verificationId: verificationId,
                  currentUser: user,
                ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<UserCredential> verifyOtp(
    String verificationId,
    String smsCode,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserModel?> getByEmail(String email) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('person.email', isEqualTo: email.trim().toLowerCase())
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
            .where('person.phone', isEqualTo: phone)
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

  Future<UserModel> initializeUserWithPhone(String phoneNumber) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: phoneNumber,
      createdAt: DateTime.now(),
      username: phoneNumber,
      isVerified: false,
      personModel: PersonModel(
        id: Uuid().v4(),
        name: phoneNumber,
        createdAt: DateTime.now(),
        firstName: '',
        lastName: '',
        profileImageUrl: null,
        email: null,
        phone: phoneNumber,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
    );
    return currentUser;
  }

  Future<UserModel> initializeUserWithEmail(String email) async {
    late UserModel currentUser;

    currentUser = UserModel(
      updatedAt: DateTime.now(),
      id: Uuid().v4(),
      name: email,
      createdAt: DateTime.now(),
      username: email,
      isVerified: false,
      personModel: PersonModel(
        id: Uuid().v4(),
        name: '',
        createdAt: DateTime.now(),
        firstName: '',
        lastName: '',
        profileImageUrl: null,
        email: email,
        phone: null,
        gender: '',
        birthDate: null,
        addresses: [],
      ),
    );
    return currentUser;
  }
}
