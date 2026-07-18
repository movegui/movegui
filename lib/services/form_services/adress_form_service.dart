import 'package:movegui/config/env_dev.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/services/form_services/form_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/seed_service.dart';
import 'package:movegui/widgets/formsControllers/address_form_controller.dart';

class AdressFormService  extends FormService<AdressModel,AddressFormController> {
  AdressFormService({required super.api});

  @override
  Future<AddressFormController> getFormController(AdressModel? model) async {
            final adressForm = AddressFormController();
        adressForm.setData(model ?? AdressModel.getDaulftObject());
        if(model == null){
          adressForm.isRegisted = true;
        }
        return adressForm;
  }
  
  @override
  Future<List<AddressFormController>> getFormControllers(List<AdressModel?> adresses) async {
     List<AddressFormController> adressesForms = [];
    int size = adresses.length ?? 0;
    if (size > 0) {
      for (int i = 0; i < size; i++) {
        final adressForm = await getFormController(adresses[i]);
        adressesForms.add(adressForm);
      }
    } else {
      final seedService = getIt<SeedService>();
      if (seedService.api.env is EnvDev) {
        final adressTestData = await seedService.getgeneratedAdress();

        adressesForms.add(AddressFormController());
        adressesForms[0].setData(adressTestData);
      } else {
        adressesForms.add(AddressFormController());
      }
    }
    return adressesForms;
  }
  
  @override
  Future<AdressModel> getModel(AddressFormController controller) async {
     return await controller.getModel();
  }
  
  @override
  Future<List<AdressModel>> getModels(List<AddressFormController> adressesForms) async {
        List<AdressModel> adresses = [];
    int size = adressesForms.length ?? 0;
    if (size > 0) {
      for (int i = 0; i < size; i++) {
        final adress = await getModel(adressesForms[i]);
        adresses.add(adress);
      }
    } 
    return adresses;
  }
}