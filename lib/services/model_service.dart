

import 'package:movegui/models/model.dart';
import 'package:movegui/services/api_service.dart';
import 'package:movegui/services/service_model.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ModelService<T extends Model> {
  final ApiService api;

  ModelService({required this.api});
  Future<T> addModel(T model);
  Future<List<T>> allModels();
  Future<List<T>> getByName(String name);
  String getCollectionName();
  Future<T> getModelById(String id);

Future<void> callNumber(String phoneNumber) async {
  final Uri uri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    /*
        MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      */
    throw Exception('Could not launch $uri');
  }
}

String getCureency(){
  return api.currency;
}

    Future<double> getTotal(List<ServiceModel> services, List<int> qtys) async {
     double sum = 0;
    for (var i = 0; i < services.length; i++) {
      final service = services[i];
      final qty = i < qtys.length ? qtys[i] : 0;
      final pricePerUnit = (service.basePrice ?? 0);
      sum += (pricePerUnit * qty);
    }
    return sum;
  }
}