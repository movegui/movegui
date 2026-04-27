import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/categories_model.dart';
import 'package:movegui/services/interfaces/i_categories.dart';
import 'package:movegui/services/model_service.dart';
import 'package:movegui/widgets/error/message_widget.dart';

class CategoriesService extends ModelService<CategoriesModel>
    implements ICategories {
  @override
  Future<void> addModel(CategoriesModel ingredient) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(ingredient.id)
        .set(ingredient.toJson());
  }

  @override
  Future<List<CategoriesModel>> allModels() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(getCollectionName()).get();

    return snapshot.docs
        .map((doc) => CategoriesModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "categories_model";
  }

  @override
  Future<List<CategoriesModel>> getByName(String name) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection(getCollectionName())
            .where('name', isEqualTo: name)
            .get();

    return snapshot.docs
        .map((doc) => CategoriesModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<CategoriesModel>> getAllCommandCategories() async {
    return await CategoriesModel.getCommandCategories();
  }

  @override
  Future<List<CategoriesModel>> getCourseCategories() async {
    return await CategoriesModel.getCourseCategories();
  }

  Future<void> onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  ) async {
    if (enabled)
      Navigator.pushNamed(context, routeName);
    else
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
  }

    Future<CategoriesModel> getById(String id) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .doc(id)
      .get();

  if (!snapshot.exists || snapshot.data() == null) {
     throw Exception("Categorie not found");
  }

  return CategoriesModel.fromJson(snapshot.data()!);
}

}
