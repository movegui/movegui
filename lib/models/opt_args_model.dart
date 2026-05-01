import 'package:firebase_auth/firebase_auth.dart';
import 'package:movegui/models/user_model.dart';

class OptArgsModel {
    final String verificationId;
  final UserModel currentUser;
  final ConfirmationResult? confirmationResult;

  OptArgsModel({required this.verificationId, required this.currentUser, required this.confirmationResult});

}