import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:movegui/models/footer_config_model.dart';

Future<FooterConfigModel> loadFooterConfig() async {
  final jsonString =
      await rootBundle.loadString('assets/config/footer_info.json');

  final data = json.decode(jsonString);

  return FooterConfigModel.fromJson(data);
}