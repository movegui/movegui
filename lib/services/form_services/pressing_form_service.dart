
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/services/form_services/form_service.dart';
import 'package:movegui/widgets/formsControllers/pressing_form_controller.dart';

class PressingFormService extends FormService<PressingModel , PressingFormController> {
  PressingFormService({required super.api});

  
  @override
  Future<PressingFormController> getFormController(PressingModel? model) {
    // TODO: implement getFormController
    throw UnimplementedError();
  }

  @override
  Future<List<PressingFormController>> getFormControllers(List<PressingModel?> models) {
    // TODO: implement getFormControllers
    throw UnimplementedError();
  }

  @override
  Future<PressingModel> getModel(PressingFormController controller) {
    // TODO: implement getModel
    throw UnimplementedError();
  }

  @override
  Future<List<PressingModel?>> getModels(List<PressingFormController> controllers) {
    // TODO: implement getModels
    throw UnimplementedError();
  }
}